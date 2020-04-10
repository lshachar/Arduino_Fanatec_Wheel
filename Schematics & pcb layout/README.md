I'm keeping the legacy PCB layouts here, as someone may want to use the version 'without display or Dpad' for simplicity.<br/>
please look inside KiCad for the most recent version.<br/>
check out Steering Wheel Photos folder, for photos describing how I have everything connected.<br/><br/>

I did not manufacture this PCB properly in a factory, but rather I milled it on a CNC machine. I used a single layer PCB (for the buttom layer in green), and the top side (red)
was meant to be connected with some jumper wires.<br/>
So, I was using vias on the design as plated through-holes, as means to attach wires to. (AFAIK there will not be holes if you sent the gerber files to a factory. The PCB layout file must be edited to create a hole first!)<br/>
note that I didn't even bother placing some of the lines (appear as white lines in the layout file) since jumper wires can easily cross over each other. with a bit of editing, all these things can be fixed so that you could get a good working PCB right from the factory.<br/>
I see that not all TM1637 display boards have the same connector, you might need to switch the order of some of the pins, or move them from the top right corner of the PCB, towards the D pad buttons, on the top left of the PCB.<br/>
The diode solves the issue I had with connectiong the wheelbase's 5V supply with the USB 5v supply coming from the computer, so it's really important.<br/>
you can use almost all the pins on the large breakout connector (J3) for buttons, except the last two - D0 and D1 on arduino are also the serial communication pins. so they are there just for debugging.<br/>
It would be useful to add another row of 8 pins to the left of J1, in order to have breakout pins for the SPI communications with the wheelbase. <br/>
AREF - there is a via, but it's not used. (it was connected to the + side of the diode, (there is a via there as well)) but it's not used. In fact, using it would create problems with the dpad buttons that are on the layout.<br/><br/>

Good luck!
