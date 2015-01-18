DMX = require('dmx')
dmx = new DMX()
universe = dmx.addUniverse('demo', 'enttec-usb-dmx-pro', 0)

RgbTween = require('./rgbtween')

class Light

  @lights = []

  constructor: (@num) ->
    @channelR = @num * 4
    @channelG = @channelR + 1
    @channelB = @channelG + 1

    Light.registerLight(@num, this)

  setColor: (hex, duration, complete) ->
    if @tween
      console.log('cancelling old tween')
      @tween.cancel()
      delete @tween

    if arguments.length == 1
      @tween = new RgbTween(Light.hexToRgb(@hex), Light.hexToRgb(hex), 1000)
    else
      @tween = new RgbTween(Light.hexToRgb(@hex), Light.hexToRgb(hex), duration)

    self = this
    @tween.onUpdate(() ->
      self.setColorImmediately(self.tween)
    )
    if complete
      @tween.onComplete(complete)
    @tween.onComplete(() ->
      delete self.tween
    )

    @tween.start()

    @hex = hex

  setColorImmediately: (rgb) ->
    channels = {}
    channels[@channelR] = rgb.r
    channels[@channelG] = rgb.g
    channels[@channelB] = rgb.b

    universe.update(channels)

  getColor: () ->
    return '0x' + ("00000000" + @hex.toString(16)).slice -6

  @hexToRgb: (hex) ->
    return {
    r: hex >> 16
    g: hex >> 8 & 0xFF
    b: hex & 0xFF
    }

  @registerLight: (num, light) ->
    @lights[num] = light

  @lights: () ->
    @lights

  @setAll: (hex) ->
    for _, light of @lights
      light.setColor(hex)
    return

module.exports = Light