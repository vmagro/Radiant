Light = require('./light')
allLights = [Light.lights()[0], Light.lights()[1], Light.lights()[2], Light.lights()[3]]

duration = 275
skip = 250
count = 0

start = ->
#  console.log('started animation')
  begin()

begin = ->
  arr = [0x990000, 0xffdd00, 0x55acee, 0x66cc66]
#  console.log('running')

  for light in allLights
    light.setColor arr[count % arr.length], duration
    count++

  count++
  setTimeout(begin,duration + skip)

end = ->
#  console.log('ending animation')

module.exports =
  start: start
  end: end