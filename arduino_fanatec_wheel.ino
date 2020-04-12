#include "pins_arduino.h" 
#include <avr/pgmspace.h>

//#define HAS_TM1637_DISPLAY	// comment out if you're not using a TM1637 4 digits 7 segment display
#ifdef  HAS_TM1637_DISPLAY
#include <TM1637Display.h>
#define TM_CLKPIN 3
#define TM_DIOPIN 4
#define TM_BRIGHTNESS 2		// (0..7), sets the brightness of the display. 0=min, 7=max
TM1637Display display = TM1637Display(TM_CLKPIN, TM_DIOPIN);
uint8_t TM_data[] = { 0x00, 0x00, 0x00, 0x00 };
#define DISPLAY_CRC8_ON_ALPHANUMERIC	// if you'd like to get 'CrC' message on the alphanumeric display, each time there's a crc8 mismatch, which means bad SPI communication with wheelbase. (message anyways gets sent to serial monitor.)
#endif

#define HAS_ANALOG_DPAD
#define DEBUG_ANALOG_DPAD	// print the DPAD value on the alphanumeric display. only relevant if you have an analog dpad and a display.

#ifdef  HAS_ANALOG_DPAD
#define DPADPIN A0
int prevDpadVal = 0;
#endif


#define dataLength 33
#define CS_ISR 2		// currently, connect SPI Cable Select pin to digital pin 2. to be changed.
#define PRINTBIN(Num) for (uint32_t t = (1UL << (sizeof(Num) * 8) - 1); t; t >>= 1) Serial.write(Num& t ? '1' : '0'); // Prints a binary number with leading zeros (Automatic Handling)

#define HASSHIFTERPADELS	// comment out if you do not have shifter pedals connected
#ifdef HASSHIFTERPADELS
#define RIGHTPADDLEPIN 9
#define RIGHTPADDLEBIT 9	// 1st bit of the 2nd button byte
#define LEFTPADDLEPIN 8
#define LEFTPADDLEBIT 12	// 1st bit of the 2nd button byte
#endif

#define HASBUTTONS
#ifdef HASBUTTONS
#define buttonsnum 6									// how many buttons are you using?
uint8_t buttonsPins[] = { A7, A6, A5, A4, A3, A2 };		// what arduino pins are you using
uint8_t buttonsBits[] = { 9 , 12,  5,  6,  7,  8 };		// what bits do you want each button to affect
#endif

uint8_t mosiBuf[dataLength];	// buffer for the incoming data on the mosi line.	
//volatile boolean process_it = false;
volatile boolean CSTest = false;
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


void setup(void)
{
	  returnData[1] = {0x03}; // for ClubSport Porshe 918 RSR - This is the only option that I'm implementing right now.
				//    {0x01} for BMW M3 GT2, {0x02} for ClubSport FORMULA, (0x04) for Uni hub

	//delay(1000);											// hit-or miss issue? https://github.com/lshachar/Arduino_Fanatec_Wheel/issues/8
	Serial.begin(250000);
	/*
	for (byte tmp = 0; tmp < dataLength ; tmp++) {			// for debugging: this loop changes the returnData to be from ascii A onwards.
		returnData[tmp] = (uint8_t)(tmp + "A");				// 65 = "A" in ascii
		Serial.print(returnData[tmp],HEX);
		Serial.print(" ");
	}
	*/

#ifdef HASSHIFTERPADELS
	pinMode(RIGHTPADDLEPIN, INPUT_PULLUP);
	pinMode(LEFTPADDLEPIN, INPUT_PULLUP);
#endif

#ifdef HAS_ANALOG_DPAD
  pinMode(DPADPIN, INPUT);
#endif

#ifdef HAS_TM1637_DISPLAY
	display.clear();
	display.setBrightness(TM_BRIGHTNESS);
	const uint8_t race[] = {0x50, 0x77, 0x58, 0x79};	// rAcE
	display.setSegments(race);
	delay(1000);
	display.clear();
#endif

	attachInterrupt(digitalPinToInterrupt(CS_ISR), cableselect, RISING);
	// SPCR BYTE should be: 11000100   note to self: by raw_capture.ino and fanatec.cpp spi settings, of btClubSportWheel by Darknao, SPI settings are SPI_Mode0 & MSBFIRST. but with logic scope I see that CPHA 1 (falling!) is used by wheel base, which means SPI_MODE1. (and MSBFIRST)
	// (Mode 1 - clock is normally low (CPOL = 0), and the data is sampled on the transition from high to low (trailing edge) (CPHA = 1))
	SPCR |= _BV(SPE);		// turn on SPI
	SPCR |= _BV(SPIE);		// turn on interrupts
	SPCR |= _BV(CPHA);		//turns on CPHA. as I found the CSW wheelbase to use it, with logic scope.
	Serial.print("SPCR byte (binary):");
	Serial.println(SPCR, BIN);   //prints byte as binary


	pinMode(MISO, OUTPUT);   // todo: to be removed!!!! https://www.reddit.com/r/arduino/comments/2m7b7q/is_it_necessary_to_use_pinmode_on_the_mosimiso/
}

void cableselect() {					// When CS line goes high - the rim should get ready to transmit the next returnData buffer, right from the begining. (so that the first byte (0xA5) will be sent out on the first Clock cycle (and after CS line went Low)
	SPCR &= ~_BV(SPIE);					// turn OFF interrupts
	//CSTest = true;
	SPDR = returnData[0];				// load first byte into SPDR single-byte's buffer
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
	readButtons();
	if (millis() > lastPrintMillis + delayMillis) {			//process_it && millis
	
		//printmosibuf();				//printmisobuf();
		returnData[selectedButtonByte] += countUpDown;
		if ((incByte == '+') || (incByte == '-')) {
			countUpDown = 0;
		}
		if (prevPrintedByte != returnData[selectedButtonByte]) {
			PRINTBIN(returnData[selectedButtonByte]);
			Serial.print("			");
			printHex(returnData[selectedButtonByte], 2);
			Serial.println();
		}
		prevPrintedByte = returnData[selectedButtonByte];
		returnData[dataLength - 1] = crc8(returnData, dataLength - 1);		// calculate crc8 for outgoing packet

		{						//crc check for incoming data
			uint8_t crc = crc8(mosiBuf, dataLength - 1);
			//Serial.print("calc crc");
			//Serial.println(crc,HEX);
			if (crc != mosiBuf[dataLength - 1])
				Serial.println("_____________incoming data crc8 mismatch!________");
		}
		alphaNumericToSerialPort();
		lastPrintMillis = millis();
	}
}

void readButtons() {
	if (!digitalRead(RIGHTPADDLEPIN)) {		// ugly temporary way!
	//returnData[selectedButtonByte] |= (1 << (tempincByte - '1'));	// if button is pressed, raise the bit that was last entered through the serial port
		returnData[3] |= 1;
	}
	else
	{
		//returnData[selectedButtonByte] &= ~(1 << (tempincByte - '1'));
		returnData[3] &= ~1;
	}
	if (!digitalRead(LEFTPADDLEPIN)) {
		returnData[3] |= (1 << 3);
	}
	else
	{
		returnData[3] &= ~(1 << 3);
	}

#ifdef HAS_ANALOG_DPAD
/*
	VALUE		MIDPOINT	BUTTON
		1023	933.5		nothing				0
		844		763			right				1	
		682		639.5		left				2
		597		505.5		left+right			3
		414		299			down				4
		184		164.5		up					5
		145		72.5		up+down(menu)		6
		0		0			Dpad button			7
*/
//uncomment the serial print command to find your analog read values in case you've used different resistors to what I used.
//Serial.println(analogRead(DPADPIN));
	int DpadRead = analogRead(DPADPIN);
	int DpadVal = 0;
	if (DpadRead > 933) DpadVal = 0; else
		if (DpadRead > 763) DpadVal = 1; else
			if (DpadRead > 639) DpadVal = 2; else
				if (DpadRead > 505) DpadVal = 3; else
					if (DpadRead > 299) DpadVal = 4; else
						if (DpadRead > 164) DpadVal = 5; else
							if (DpadRead > 72) DpadVal = 6; else
								DpadVal = 7;



	if (DpadVal != prevDpadVal) {		// only if button has changed, do something
		Serial.println(DpadVal);
		

#if defined HAS_ANALOG_DPAD && defined HAS_TM1637_DISPLAY && defined DEBUG_ANALOG_DPAD
		// print the dpad value on the lcd screen
		byte dpadalpha;
		switch (DpadVal) {
			case 0:	dpadalpha=0x3f; break;
			case 1: dpadalpha = 0x6; break;
			case 2: dpadalpha = 0x5b; break;
			case 3: dpadalpha = 0x4f; break;
			case 4: dpadalpha = 0x66; break;
			case 5: dpadalpha = 0x6d; break;
			case 6: dpadalpha = 0x7d; break;
			case 7: dpadalpha = 0x7; break;
			case 8: dpadalpha = 0x7f; break;
		}

		TM_data[0] = dpadalpha;
		display.setSegments(TM_data);	// todo: try display.showNumberDec(dpadalpha,false);
#endif		
		
			
		switch (prevDpadVal) {			// turn the previous button bit off.		todo:write this in a function
		case 0: break;
		case 1:	// right
			returnData[2] &= ~(1 << 2); break;
		case 2:	// left
			returnData[2] &= ~(1 << 1); break;
		case 3: // left+right
			returnData[2] &= ~(11 << 1); break;
		case 4:	// down
			returnData[2] &= ~(1 << 3); break;
		case 5:	// up
			returnData[2] &= ~1;		break;
		case 6: // up+down (menu)
			returnData[4] &= ~(1 << 5); break;
		case 7: // Dpad button
			//returnData[4] &= ~(1 << 1); break;
			returnData[3] &= ~2; break;	// right paddle
		
		}

		switch (DpadVal) {			// turn the curernt button bit on.	
		case 0: break;
		case 1:	// right
			returnData[2] |= (1 << 2); break;
		case 2:	// left
			returnData[2] |= (1 << 1); break;
		case 3: // left+right
			returnData[2] |= (11 << 1); break;
		case 4:	// down
			returnData[2] |= (1 << 3); break;
		case 5:	// up
			returnData[2] |= 1;		break;
		case 6: // up+down (menu)
			returnData[4] |= (1 << 5); break;
		case 7: // Dpad button
			//returnData[4] |= (1 << 1); break;
			returnData[3] |= 2; break;	// right paddle

		}
		/*
				returnData[selectedButtonByte] ^= (1 << (incByte - '1'));	// toggles bit correcsponding to number read by serial print
			*/
		
	}
	prevDpadVal = DpadVal;
#endif

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
		if ((incByte >= 'A') && (incByte <= 'J')) {		// send A,B,C to choose 1st, 2nd, 3rd button byte
			selectedButtonByte = (incByte - 'A' + 2); 	// first button byte is 3rd in array, or cell no 2 to cell no 4 in array
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
	for (int i = 2; i <= 4; i++) {						// cells 2 to 4 in miso data is alphanumeric data
		if (mosiBuf[i] != prevAlphaDisp[i - 2]) {		// if anything on the display changed, reprint
			displaychanged = true;
			break;
		}
	}
	if (displaychanged) {
		for (int i = 2; i <= 4; i++) {
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
			case 0x3e:  Serial.print("u"); break;
			case 0x2A:	Serial.print("*"); break;   // this should really be a floating 'o' (displayed on the top square) but I couldn't find an ascii character for that
			default:	printHex(p, 2);	   break;
			}
			if (mosiBuf[i] & 0x80)							// select only the . (dot) bit
				Serial.print(". ");
			else
				Serial.print("  ");

			prevAlphaDisp[i - 2] = mosiBuf[i];
		}
		Serial.println();
#ifdef HAS_TM1637_DISPLAY
		for (int i = 2; i <= 4; i++) {
			TM_data[i-2] = mosiBuf[i];
		}
		display.setSegments(TM_data);
#endif
	}
}


void printmosibuf() {
	Serial.print("MOSI:");
	for (int i = 0; i < dataLength; i++)
	{
		printHex(mosiBuf[i], 2);
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
