#Leaping Propellers

A simple demonstration piece to turn on up to 8 LEDs connected to a Parallax Propeller based on the number of fingers seen by a Leap Motion. The brightness of the LEDs is controlled by the distance the fingers are from the Leap.

##Propeller 
* Use the [Propeller Tool](http://www.parallax.com/downloads/propeller-tool-software) to flash PropPWM.spin to a Parallax Propeller
* Connect NPN transistors to pins 17-24 driving LEDs
* Plug the Propeller into computer
* Open a Device manager and find the COM port of the Propeller

##Chrome Extension
* Modify line 56 to point to the COM port of the Propeller
* Visit [chrome://extensions](chrome://extensions) 
* Click "Load unpacked extensions..." and browse to the location of the repository
* Click on "Launch"
