# Pro Mini V2 3.3V 16 MHz
What you'll need:
* Fanatec QR
* [Pro Mini V2](https://www.ebay.com/itm/Enhancement-V2-Pro-Mini-328-16Mhz-3-3V-5V-adjustable-Arduino-Compatible-40Pins/324180291509?hash=item4b7aa6afb5:g:~UgAAOxymiVQ~6z~)
* FTDI Adapter USB to TTL Programmer
* PCB [can be found here](eagle%20pcb%20files/Gerber.zip)
  * upload `Gerber.zip` to a PCB service like JLCPCB and order them
* 6x M5x20mm countersunk screws (e.g. DIN 7991)

optional:
* 8 pin JST connector
* 2x M2.5 screws to secure the pcb to the 3D model

# How To
* Make sure that the solder bridge on the Pro Mini is set to 3.3V
* uncomment following lines:
  * `#define HAS_TM1637_DISPLAY` - we are not using the TM1637 display module
  * `#define HAS_ANALOG_DPAD` - otherwise the funky switch is constantly pressed
* Program the Pro Mini using the option ATmega328P (5V, 16 MHz)
* Mark the cable coming from the QR which is 5V
* Solder the cables onto the pcb. Make sure that the marked cable (5V) is aligned with the 5V PCB pin
  * You can either solder the wires coming from the Fanatec QR directly to the PCB (recommended) or use an 8 pin JST connector so you can plug the cables coming from the QR into it
  * I had connection problems using the JST connector as the cable did not stick in correctly all the time, so I just soldered the wires and everything worked fine afterwards.
* Bend the cable so that it fits into the QR housing like so:
![Bent cable](photos/02.JPG)
![Bent cable 2](photos/01.JPG)
* Take the 3D printed QR adapter, put two M2.5 screws into each hole to secure the pcb
* Make sure that the cable is not squeezed and use the six M5 screws to mount it to the Fanatec QR
* Done!
![Done](photos/03.JPG)
![Done2](photos/04.JPG)

# Warning
If you ever connect the FTDI to the board while also having it connected to the wheelbase **make sure to remove the VCC pin on the FTDI interface**, otherwise it might **damage your wheelbase** because this will connect the 3.3V coming from the FTDI with the 3.3V of the wheelbase.

# Downsides
* In some rare cases my base reconnects if I connect the emulator to it. Nothing wild, just let it recalibrate and you're ready to race