Light = require('./light')
allLights = [Light.lights()[0], Light.lights()[1], Light.lights()[2], Light.lights()[3]]

duration = 375
skip = 250
count = 0

start = ->
  console.log('started animation')
  begin()

begin = ->
  arr = [0xff3322, 0xffdd00, 0x66cc66, 0x55acee]

  for light in allLights
    light.setColor arr[count % arr.length], duration
    count++
    setTimeout(begin, duration + skip)

end = ->
  console.log('ending animation')

module.exports =
  start: start
  end: end