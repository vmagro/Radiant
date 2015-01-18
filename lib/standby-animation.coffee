child_process = require('child_process')

Light = require('./light')
evenLights = [Light.lights()[0], Light.lights()[2]]
oddLights = [Light.lights()[1], Light.lights()[3]]

child = null

start = ->
#  console.log('starting wait animation')
  child = child_process.fork('./lib/standby-animation-child')
  child.on('message', (msg) ->
    if msg.odd
      for light in oddLights
        light.setColorImmediately(msg.odd)
    if msg.even
      for light in evenLights
        light.setColorImmediately(msg.even)
  )

end = ->
  if child
    child.kill()

module.exports =
  start: start
  end: end