#include "pins_arduino.h" 
#include <avr/pgmspace.h>
 
#define dataLength 33
#define CS_ISR 2		// currently, connect SPI Cable Select pin to digital pin 2. to be changed.
#define PRINTBIN(Num) for (uint32_t t = (1UL << (sizeof(Num) * 8) - 1); t; t >>= 1) Serial.write(Num& t ? '1' : '0'); // Prints a binary number with leading zeros (Automatic Handling)
#define RIGHTPADDLEPIN 8
#define RIGHTPADDLEBIT 9 // 1st bit of the 2nd button byte

uint8_t mosiBuf[dataLength];	// buffer for the incoming data on the mosi line.	
volatile boolean process_it = false;
volatile unsigned long lastPrintMillis = 0;
int selectedButtonByte = 2;		// button bytes are 3rd to 5th. initialize to 1st relevant byte.
int countUpDown = 0;
uint8_t tempincByte, incByte, prevPrintedByte, prevAlphaDisp[3];
volatile uint8_t isrIndex = 0;
unsigned long delayMillis = 400; // wait at least the delay time since last spi communication before printing out whatever came in.


// CRC lookup table with polynomial of 0x131
PROGMEM const unsigned char _crc8_table[256] = {
  0, 94, 188, 226, 97, 63, 221, 131,
  194, 156, 126, 32, 163, 253, 31, 65,
  157, 195, 33, 127, 252, 162, 64, 30,
  95, 1, 227, 189, 62, 96, 130, 220,
  35, 125, 159, 193, 66, 28, 254, 160,
  225, 191, 93, 3, 128, 222, 60, 98,
  190, 224, 2, 92, 223, 129, 99, 61,
  124, 34, 192, 158, 29, 67, 161, 255,
  70, 24, 250, 164, 39, 121, 155, 197,
  132, 218, 56, 102, 229, 187, 89, 7,
  219, 133, 103, 57, 186, 228, 6, 88,
  25, 71, 165, 251, 120, 38, 196, 154,
  101, 59, 217, 135, 4, 90, 184, 230,
  167, 249, 27, 69, 198, 152, 122, 36,
  248, 166, 68, 26, 153, 199, 37, 123,
  58, 100, 134, 216, 91, 5, 231, 185,
  140, 210, 48, 110, 237, 179, 81, 15,
  78, 16, 242, 172, 47, 113, 147, 205,
  17, 79, 173, 243, 112, 46, 204, 146,
  211, 141, 111, 49, 178, 236, 14, 80,
  175, 241, 19, 77, 206, 144, 114, 44,
  109, 51, 209, 143, 12, 82, 176, 238,
  50, 108, 142, 208, 83, 13, 239, 177,
  240, 174, 76, 18, 145, 207, 45, 115,
  202, 148, 118, 40, 171, 245, 23, 73,
  8, 86, 180, 234, 105, 55, 213, 139,
  87, 9, 235, 181, 54, 104, 138, 212,
  149, 203, 41, 119, 244, 170, 72, 22,
  233, 183, 85, 11, 136, 214, 52, 106,
  43, 117, 151, 201, 74, 20, 246, 168,
  116, 42, 200, 150, 21, 75, 169, 247,
  182, 232, 10, 84, 215, 137, 107, 53
};


// Uni hub packet (change to other steering wheels in setup() )
uint8_t returnData[dataLength] = { 0xA5, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x13, 0xfc };


// return CRC8 from buf
uint8_t crc8(const uint8_t* buf, uint8_t length) {
	uint8_t crc = 0xff;
	while (length) {
		crc = pgm_read_byte_near(_crc8_table + (*buf ^ crc));
		buf++;
		length--;
	}
	return crc;
}

                                
void setup (void)
{
  
  //returnData[1] = {0x01}; // uncomment for BMW M3 GT2
  //returnData[1] = {0x02}; // uncomment for ClubSport FORMULA
    returnData[1] = {0x03}; // uncomment for ClubSport Porshe 918 RSR - This is the only option that I'm fully implementing right now.
  //returnData[1] = (0x04); // uncomment for Uni hub


	Serial.begin(115200);
	/*
	for (byte tmp = 0; tmp < dataLength ; tmp++) {			// for debugging: this loop changes the returnData to be from ascii A onwards.
		returnData[tmp] = (uint8_t)(tmp + "A");				// 65 = "A" in ascii
		Serial.print(returnData[tmp],HEX);
		Serial.print(" ");
	}
	*/	
	pinMode(MISO, OUTPUT);
  pinMode(RIGHTPADDLEPIN, INPUT_PULLUP);
	attachInterrupt(digitalPinToInterrupt(CS_ISR), cableselect, RISING);
	// SPCR BYTE should be: 11000100   note to self: by raw_capture.ino and fanatec.cpp spi settings, of btClubSportWheel by Darknao, SPI settings are SPI_Mode0 & MSBFIRST. but with logic scope I see that CPHA 1 (falling!) is used by wheel base, which means SPI_MODE1. (and MSBFIRST)
	// (Mode 1 - clock is normally low (CPOL = 0), and the data is sampled on the transition from high to low (trailing edge) (CPHA = 1))
	SPCR |= _BV(SPE);		// turn on SPI
	SPCR |= _BV(SPIE);		// turn on interrupts
	SPCR |= _BV(CPHA);		//turns on CPHA. as I found the CSW wheelbase to use it, with logic scope.
	Serial.print("SPCR byte (binary):");
	Serial.println(SPCR, BIN);   //prints byte as binary
}

void cableselect() {					// When CS line goes high - the wheel should get ready to transmit the next returnData buffer, right from the begining. (so that the first byte (0xA5) will be sent out on the first Clock cycle (and after CS line went Low)
	SPCR &= ~_BV(SPIE);					// turn OFF interrupts
	SPDR = returnData[0];				// load first byte into SPDR 'buffer'
	isrIndex = 0;						// on next SPI interrupt(SPI_STC_vect), load the 2nd byte

	SPCR |= _BV(SPIE);					// turn on interrupts
}


// SPI interrupt routine
ISR(SPI_STC_vect)
{
	byte c = SPDR;
	mosiBuf[isrIndex] = c;
	isrIndex++;
	if (isrIndex >= dataLength) {
		isrIndex = 0;
	}
	SPDR = returnData[isrIndex];
	//process_it = true;
}


void loop(void)
{
	readSerial();
  //readButtons();
	if (millis() > lastPrintMillis + delayMillis) {			//process_it && millis
		//printmosibuf();				//printmisobuf();
		returnData[selectedButtonByte] += countUpDown;
		if ((incByte == '+') || (incByte == '-')) {
			countUpDown = 0;
		}
		if (prevPrintedByte != returnData[selectedButtonByte]) {
			PRINTBIN(returnData[selectedButtonByte]);
			Serial.print("			");
			printHex(returnData[selectedButtonByte],2);
			Serial.println();
		}
		prevPrintedByte = returnData[selectedButtonByte];
		returnData[dataLength - 1] = crc8(returnData, dataLength - 1);		// calculate crc8 for outgoing packet
		
		{						//crc check for incoming data
			uint8_t crc = crc8(mosiBuf, dataLength - 1);
			//Serial.print("calc crc");
			//Serial.println(crc,HEX);
			if (crc != mosiBuf[dataLength-1])
				Serial.println("_____________incoming data crc8 mismatch!________");
		}
		alphaNumericToSerialPort();
		lastPrintMillis = millis();
	}
}

void readButtons() {
    if (!digitalRead(RIGHTPADDLEPIN)) {
    returnData[selectedButtonByte] |= (1 << (tempincByte - '1'));	// if button is pressed, raise the bit that was last entered through the serial port
    //returnData[3] |= 1 ; 
  }
  else
  {
    returnData[selectedButtonByte] &= ~(1 << (tempincByte - '1'));
    //returnData[3] &= ~1;
  }
}

void readSerial() {
	// read user inputs from serial connection
	if (Serial.available() > 0) {
		incByte = Serial.read();
		Serial.println((char)incByte);
		if (incByte == 'i')
			printmosibuf();
		if (incByte == 'o')
			printmisobuf();
		if (incByte == 's')
			countUpDown = 0;
		if ((incByte == 'f') || (incByte == '+'))
			countUpDown = 1;
		if ((incByte == 'b') || (incByte == '-'))
			countUpDown = -1;
		if (incByte == 'd')
			alphaNumericToSerialPort();
		if ((incByte >= 'A') && (incByte <= 'J')) {		// send a,b,c to choose 1st, 2nd, 3rd button byte
			selectedButtonByte = (incByte - 'A'+ 2 ); 	// first button byte is 3rd in array, or cell no 2 to cell no 4 in array
			Serial.print("Selected button byte:");
			Serial.println(selectedButtonByte);
			PRINTBIN(returnData[selectedButtonByte]);
			Serial.print("			");
			printHex(returnData[selectedButtonByte], 2);
			Serial.println();
		}

		if ((incByte >= '1') && (incByte <= '8'))
		{
			returnData[selectedButtonByte] ^= (1 << (incByte - '1'));	// toggles bit correcsponding to number read by serial print
			printmisobuf();
      tempincByte = incByte;
		}
	}
}

void printHex(int num, int precision) {
     char tmp[16];
     char format[128];
     sprintf(format, "0x%%.%dX", precision);
     sprintf(tmp, format, num);
     Serial.print(tmp);
}

void alphaNumericToSerialPort() {
	// send alphanumeric numbers to serial port

	bool displaychanged = false;
	for (int i = 2; i <= 4; i++) {					// cells 2 to 4 in miso data is alphanumeric data
		if (mosiBuf[i] != prevAlphaDisp[i-2])			// don't reprint if already printed
		{
			displaychanged = true;
			uint8_t p = mosiBuf[i] & 0x7F;				// remove the . (dot) bit
			switch (p) {
			case 0x3f:	Serial.print("0"); break;
			case 0x6:	Serial.print("1"); break;
			case 0x5b:	Serial.print("2"); break;
			case 0x4f:	Serial.print("3"); break;
			case 0x66:	Serial.print("4"); break;
			case 0x6d:	Serial.print("S"); break;
			case 0x7d:	Serial.print("6"); break;
			case 0x7:	Serial.print("7"); break;
			case 0x7f:	Serial.print("8"); break;
			case 0x6f:	Serial.print("9"); break;
			case 0x39:	Serial.print("C"); break;
			case 0x38:	Serial.print("L"); break;
			case 0x8:	Serial.print("_"); break;
			case 0x79:	Serial.print("E"); break;
			case 0x54:	Serial.print("n"); break;
			case 0x71:	Serial.print("F"); break;
			case 0x76:	Serial.print("H"); break;
			case 0x5c:	Serial.print("o"); break;
			case 0x77:	Serial.print("A"); break;
			case 0x7c:	Serial.print("b"); break;
			case 0x5e:	Serial.print("d"); break;
			case 0x50:	Serial.print("r"); break;
			case 0x30:	Serial.print("I"); break;
			case 0x73:	Serial.print("P"); break;
			case 0x78:	Serial.print("t"); break;
			case 0x40:	Serial.print("-"); break;
      case 0x3e: Serial.print("u"); break;
			case 0x2A:	Serial.print("*"); break;   // this should really be a floating 'o' (displayed on the top square)
			default:	printHex(p, 2);	   break;
			}
			if (mosiBuf[i] & 0x80)							// select only the . (dot) bit
				Serial.print(". ");
			else
				Serial.print("  ");

			prevAlphaDisp[i-2] = mosiBuf[i];
		}
	}
	if (displaychanged) Serial.println();
}


void printmosibuf() {
	Serial.print("MOSI:");
	for (int i = 0; i < dataLength; i++)
	{
		printHex(mosiBuf[i],2);
		//Serial.print(mosiBuf[i],HEX);
		Serial.print(" ");

	}
	Serial.println();
}

void printmisobuf() {
	Serial.print("MISO:");
	for (int i = 0; i < dataLength; i++) {
		printHex(returnData[i], 2);
		//Serial.print(returnData[i], HEX);
		Serial.print(" ");
	}
	Serial.println();
}




/*
Clubsport wheel buttons, by bit, from 3rd cell on miso array to 5th cell
1	D-pad Up
2	D-pad Left
3	D-pad Right
4	D-pad Down
5	Button 11
6	Button 3
7	Button 6
8	Button 4
B
9(1)	Right Paddle
10(2)	button 2
11(3)	button 8
12(4)	left paddle
13(5)	button 1
14(6)	button 5
15(7)	button 9
16(8)	button 10 (START)
C
17(1)	button 21 through contentmanager. does not show up in fanatec's driver
18(2)	D-pad Button
19(3)	Joystick Button
20(4)	Button 7
21(5)	button 27 through contentmanager. does not show up in fanatec's driver
22(6)	Menu button. (button 28 through contentmanager. does not show up in fanatec's driver)
23(7)
24(8)

button 8 on fanatec's driver, number 11 on this list, is controlled by 3rd bit on 2nd byte, of the 3 bytes that control buttons.

C6 - enters menu
B8C6 - enters shifter calibration mode

C6 6 23 23 6 6 - calibrates wheel center
*/
