# Arduino_Fanatec_Wheel
A do-it-yourself steering wheel to Fanatec's wheel base.<br/><br/>
  
This project would never have been possible without the work of Darknao on his [BtClubSportWheel - converting any Fanatec CSW steering wheel to a standalone USB version](https://github.com/darknao/btClubSportWheel) project.
  
Fanatec's wheelbases won't enable any force feedback, unless you have a Fanatec steering wheel attached to them.
With this project, you can use an arduino to communicate with the wheelbase over SPI, which will get the wheelbase working.
buttons also work, but I still have lots of code and schematics to write. and then build. This project is in the works and about to change.

This project is donationware; if my work helped you out [please donate!](https://paypal.me/lshachar?locale.x=en_US)<br/><br/>


Here's a [how to make a male Fanatec SPI connector](Steering%20wheel%20connector%20-%20howto/Readme.md) (what the steering wheel has)<br/><br/>

[use this](3d%20Models/fanatec%20adapter%20v1.STL) If you need a simple 3d adapter to attach your physical steering wheel to the wheelbase<br/><br/>

Code was tested on arduino Uno and Nano, and works fine. However, they both output 5V and the SPI communication on the wheelbase
is using 3.3V.
It's best to use a level shifter between the two, so there are no chances of damaging the wheelbase (by connecting the 5V arduino 
output to a 3.3V wheelbase input)
However, since the wheelbase is the master and the steering wheel is the slave - MISO is the only *input* channel on the wheelbase,
and it is safe to simply use a voltage divider on the MISO line - to go from 5V level to 3.3V. (The arduino should recognize the 3.3V input signals coming from the wheelbase as high, so there's nothing we have to do there).
Note: If you do end up going this route, make sure you wire everything up properly, and that you never set SPI master on the arduino, or you will subject the wheelbase SPI to 5V. (I did subject the wheelbase SPI to 5V by mistake - and nothing got damaged.)

Won't it be easier to just switch to a 3.3V arduino? - Yes, probably, but most 3.3V arduinos run at 8MHZ, (16MHZ for the 5V boards), and I'm not sure if this will become an issue or not once I have everything implemented.

[There's a lot of info over here](https://github.com/darknao/btClubSportWheel/issues/12)


# What to do if you gotta calibrate your wheelbase?
You can use the current code to calibrate the wheelbase's center point. (This is needed after a firmware upgrade for the wheelbase) the arduino will translate the alphanumeric display to letters and send them out to the Serial monitor(!). you will need to type in some commands on the Serial monitor, which will look pretty cypheric to you.
Type these characters on the serial monitor, press [return] after every line: <br/><br/>
C		(to change bits on the 3rd byte that affects buttons)  
6		(to change (raise) the sixth bit on the 3rd byte, which is the menu button. this will cause the alphanumeric display to turn on and the message '5_1' (equivilent to 'S_1' i.e. 'setting 1') will be printed on the serial monitor.)  
6		(to release the menu button (lower the 6th bit) )  
23		(2 will raise the D-pad button bit, 3 will raise the joystick button bit.)  
23		(to release both buttons)  
6		(press the menu button again to exit the menu)  
6		(release the menu button)  
[Watch this If you don't know what I'm talking about](https://www.youtube.com/watch?v=yvhAKxjit8o)  

(Hey - this is pretty awful procedure right now, but at least it's working!)
