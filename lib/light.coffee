DMX = require('dmx')
dmx = new DMX()
universe = dmx.addUniverse('demo', 'enttec-usb-dmx-pro', 0)

class Light

  constructor: (@num) ->
    @channelR = @num * 4
    @channelG = @channelR + 1
    @channelB = @channelG + 1

  setColor: (@hex) ->
    rgb = @hexToRgb(@hex)

    channels = {}
    channels[@channelR] = rgb.r
    channels[@channelG] = rgb.g
    channels[@channelB] = rgb.b

    universe.update channels

  getColor: () ->
    return '0x' + ("00000000" + @hex.toString(16)).slice -6

  hexToRgb: (hex) ->
    return {
    r: hex >> 16
    g: hex >> 8 & 0xFF
    b: hex & 0xFF
    }

module.exports = Light