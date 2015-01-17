To fix FT_DEVICE_NOT_OPENED error on Linux:
````
sudo rmmod ftdi_sio  
sudo rmmod usbserial
````

On Mac:
````
sudo kextunload -b com.apple.driver.AppleUSBFTDI
````

Set lights
----------

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