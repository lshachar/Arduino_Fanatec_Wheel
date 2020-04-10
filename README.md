# Arduino_Fanatec_Wheel
A do-it-yourself steering wheel to Fanatec's wheel base.<br/><br/>
**31.12.2019 update:** [added support for a TM1637 module](https://raw.githubusercontent.com/lshachar/Arduino_Fanatec_Wheel/master/Schematics%20%26%20pcb%20layout/TM1637%20display.jpg), a 7 segments 4 digits display (only 3 digits are used). buy the display version that has decimal dots next to each digit! (the version I got is designed to display time, and does not have the 8th segment that is used as a dot ".").<br/>Copy the /libraries/TM1637/ folder to your arduino libraries folder (or install the library in any other way)<br/>
[connect arduino D3 to CLK, and D4 to DIO. display works on 5V.](https://raw.githubusercontent.com/lshachar/Arduino_Fanatec_Wheel/master/Schematics%20%26%20pcb%20layout/how%20it%20looks%20like%20-%20with%20display%20and%20some%20buttons.png)<br/>

**26.11.2019 update:** [new schematics and pcb layout.](https://raw.githubusercontent.com/lshachar/Arduino_Fanatec_Wheel/master/Schematics%20%26%20pcb%20layout/how%20it%20looks%20like.png) To be manufactured from a single layer board (bottom layer only). The top can easily be connected with some pieces of wire. (in the 3d screenshot file, the bottom layer is displayed on the top of the board - simply for better visualization.) The traces are extra big since I plan on attempting to fabricate the PCB on a CNC milling machine.<br/>

**This project is donationware; if my work helped you out** [**please buy me a beer!**](https://paypal.me/lshachar?locale.x=en_US)<br/><br/>
  
This project would never have been possible without the work of Darknao on his [BtClubSportWheel - converting any Fanatec CSW steering wheel to a standalone USB version](https://github.com/darknao/btClubSportWheel) project.
  
Fanatec's wheelbases won't enable any force feedback, unless you have a Fanatec steering wheel attached to them.
With this project, you can use an arduino to communicate with the wheelbase over SPI, which will get the wheelbase working.
buttons also work, but there is a pesky delay issue for a yet unknown reason.


Here's a [how to make a male Fanatec SPI connector](Steering%20wheel%20connector%20-%20howto/Readme.md) (what the steering wheel has)<br/>
Also, [Alevale found where to buy the connector](https://github.com/darknao/btClubSportWheel/issues/14#issuecomment-604973137)<br/><br/>
[use this](3d%20Models/fanatec%20adapter%20v1.STL) If you need a simple 3d adapter to attach your physical steering wheel to the wheelbase<br/><br/>



### Several options:
- Use a 5V arduino with a logic level shifter. (recommended, this is what I use. [(here are The schematics)](https://github.com/lshachar/Arduino_Fanatec_Wheel/blob/master/schamtics%20arduino%20nano-level%20shifter-fanatec%20round%20plug.png)
- Use a 5V arduino **without** a logic shifter (can be risky to your precious wheelbase)
- Use a 3.3V arduino (I haven't tried it)

Code was tested on arduino Uno and Nano, and works fine. However, they both output 5V and the SPI communication on the wheelbase
is using 3.3V.
It's best to use a level shifter between the two, so there are no chances of damaging the wheelbase (by connecting the 5V arduino 
output to a 3.3V wheelbase input)
However, since the wheelbase is the master and the steering wheel is the slave - MISO is the only *input* channel on the wheelbase,
and it is safe to simply use a voltage divider on the MISO line - to go from 5V level to 3.3V. (The arduino should recognize the 3.3V input signals coming from the wheelbase as high, so there's nothing we have to do there). <br/>
- **Note:** If you do end up going this route, make sure you wire everything up properly, and that you never set SPI as master on the arduino, or you will subject the wheelbase SPI to 5V. (I did subject the wheelbase SPI to 5V by mistake - and nothing got damaged.)<br/><br/>

I recommend using an arduino nano and a logic shifter, as seen in the schematics.
- **Note:** When you connect the arduino by USB cable to your computer, you are connecting the +5V power supply on your USB socket (your computer PSU), to the +5V power supply of your wheelbase.<br/>
I've done this, and have not had issues with that, but this should be avoided...<br/>
One of these supplies will have a slightly higher voltage than the other, and it will push current through the other supply. (similar to connecting two batteries in parallel. The charged battery will try to charge the drained battery.)<br/>
So, it is better if you disconnected the 4 pin on the round plug from VIN before you connected the arduino to the computer. (as a temporary solution) or better, a permament fix:<br/>
- Modify your micro USB cable, cut off the 5V wire.<br/>
- Cut the 5V trace coming from the USB connector on the arduino nano.<br/>


Won't it be easier to just switch to a 3.3V arduino? - Yes, probably, but most 3.3V arduinos run at 8MHZ, (16MHZ for the 5V boards), and I'm not sure if this will become an issue or not once I have [the buttons](https://github.com/darknao/btClubSportWheel/issues/12#issuecomment-522373884) implemented.

[There's a lot of info over here](https://github.com/darknao/btClubSportWheel/issues/12)


# What to do if you gotta calibrate your wheelbase center?
On some wheelbases, you can do that directly from the [Fanatec wheel properties page](https://github.com/lshachar/Arduino_Fanatec_Wheel/issues/7). unfortunately it doesn't work on my CSW V2.5.<br/>
You can use the current code to calibrate the wheelbase's center point. (This is needed after a firmware upgrade for the wheelbase) the arduino will translate the alphanumeric display to letters and send them out to the Serial monitor(!). you will need to type in some commands on the Serial monitor, which will look pretty cypheric to you.
Type these characters on the serial monitor, press [return] after each line: <br/><br/>
C		(to change bits on the 3rd byte that affects buttons. C=3rd)
6		(to change (raise) the sixth bit on the 3rd byte, which is the menu button. this will cause the alphanumeric display to turn on and the message '5_1' (equivilent to 'S_1' i.e. 'setting 1') will be printed on the serial monitor.)  
6		(to release the menu button (lower the 6th bit) )  
23		(2 will raise the D-pad button bit, 3 will raise the joystick button bit.)  
23		(to release both buttons, drop both bits)
6		(press the menu button again to exit the menu)  
6		(release the menu button)  
[Watch this If you don't know what I'm talking about](https://www.youtube.com/watch?v=yvhAKxjit8o)  

(Hey - it's not an easy procedure, but at least it works!
