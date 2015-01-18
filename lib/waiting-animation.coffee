Light = require('./light')
evenLights = [Light.lights()[0], Light.lights()[2]]
oddLights = [Light.lights()[1], Light.lights()[3]]

duration = 375
skip = 250

timeout = -1

start = ->
  console.log('starting wait animation')
  step1()

step1 = ->
  for light in evenLights
    light.setColor 0x990000, duration
  for light in oddLights
    light.setColor 0xffcc00, duration

  timeout = setTimeout(step2, duration + skip)

step2 = ->
  for light in evenLights
    light.setColor 0xffcc00, duration
  for light in oddLights
    light.setColor 0x990000, duration

  timeout = setTimeout(step1, duration + skip)

end = ->
  clearTimeout(timeout)

module.exports =
  start: start
  end: end