#Radiant

Radiant is the first true mood lighting platform.  We use data from the [Muse Brain Sensing Headband](http://www.choosemuse.com/)  to turn your brain waves into a reactive ambient lighting display.  

Use it to help relax when you get home, or to understand and visualize what your brain is actually doing as you engage in different tasks.  In addition to visualizing how calm or concentrated you are while doing different things, blinks and jaw clenches prompt different lighting reactions.

We built Radiant using the Muse headband and an array of LED lighting fixtures each consisting of 7x10 watt RGBW addressable LEDs.  The Muse sends data over Bluetooth and the lights receive output from Radiant via a USB DMX interface.

Our software stack includes Node.js, Express, Knockout.js, CoffeeScript, Flot charts, the DMX lighting control protocol, and the OSC sensor data protocol.

##Setup
Pair Muse and run:
````
muse-io --preset 14 --device Muse --osc osc.udp://localhost:5000
````
Start Radiant:
````
grunt
````
##DMX Drivers

To fix FT_DEVICE_NOT_OPENED error on Linux:
````
sudo rmmod ftdi_sio  
sudo rmmod usbserial
````

On Mac:
````
sudo kextunload -b com.apple.driver.AppleUSBFTDI
````

##Set lights

JavaScript
```javascript
var Light = require('./lib/light'); //or whatever the path to lib is
Light.setAll(0x002200); //to set all lights to a light green
Light.lights(); //get access to individual Light objects for more fine-grained control
```

Coffeescript
```coffeescript
Light = require('./lib/light')
Light.setAll 0x002200
Light.lights
```
