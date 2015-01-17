events = require('events')

stepLength = 10

class RgbTween

  constructor: (start, @target, @duration) ->
    @emitter = new events.EventEmitter()
    @r = start.r
    @g = start.g
    @b = start.b

    @rStep = (@target.r - @r) / (@duration / stepLength)
    @gStep = (@target.g - @g) / (@duration / stepLength)
    @bStep = (@target.b - @b) / (@duration / stepLength)

    @rInc = @target.r - @r > 0
    @gInc = @target.g - @g > 0
    @bInc = @target.b - @b > 0

  onUpdate: (cb) ->
    @emitter.on('update', cb)

  onComplete: (cb) ->
    @emitter.on('complete', cb)

  start: () ->
    @step()

  step: () ->
    @r += @rStep
    @g += @gStep
    @b += @bStep

    if (@rInc and @r > @target.r) or (not @rInc and @r < @target.r)
      @r = @target.r

    if (@gInc and @g > @target.g) or (not @gInc and @g < @target.g)
      @g = @target.g

    if (@bInc and @b > @target.b) or (not @bInc and @b < @target.b)
      @b = @target.b

    @emitter.emit('update')

    if @r == @target.r and @g == @target.g and @b == @target.b
      clearTimeout(@timeout)
      @emitter.emit('complete')
    else
      @timeout = setTimeout(@step.bind(this), stepLength)


module.exports = RgbTween