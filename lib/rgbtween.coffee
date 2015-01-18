events = require('events')

chroma = require('chroma-js')

stepLength = 10

class RgbTween

  constructor: (start, @target, @duration) ->
    @emitter = new events.EventEmitter()
    @r = start.r
    @g = start.g
    @b = start.b

    @scale = chroma.scale([RgbTween.rgbToHex(start), RgbTween.rgbToHex(@target)])
    @scaleMultiple = 0.0

    @scaleDelta = 1.0 / (@duration / stepLength)

  onUpdate: (cb) ->
    @emitter.on('update', cb)

  onComplete: (cb) ->
    @emitter.on('complete', cb)

  start: () ->
    @step()

  cancel: () ->
    clearTimeout(@timeout)

  step: () ->
    color = @scale(@scaleMultiple)._rgb
    @r = color[0]
    @g = color[1]
    @b = color[2]

    @emitter.emit('update')

    if @scaleMultiple > 1 or (@r == @target.r and @g == @target.g and @b == @target.b)
      clearTimeout(@timeout)
      @emitter.emit('complete')
    else
      @timeout = setTimeout(@step.bind(this), stepLength)

    @scaleMultiple += @scaleDelta

  @rgbToHex: (rgb) ->
    hex = (rgb.r << 16) + (rgb.g << 8) + rgb.b
    '#' + ("00000000" + hex.toString(16)).slice(-6)
module.exports = RgbTween