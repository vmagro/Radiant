RgbTween = require('./rgbtween')
Light = require('./light')

duration = 375
skip = 250

timeout = -1

step1 = ->
  toCardinal = new RgbTween(Light.hexToRgb(0xffcc00), Light.hexToRgb(0x990000), duration)
  toGold = new RgbTween(Light.hexToRgb(0x990000), Light.hexToRgb(0xffcc00), duration)

  toCardinal.onUpdate =>
    process.send({even: {
      r: toCardinal.r
      g: toCardinal.g
      b: toCardinal.b
    }})
  toGold.onUpdate =>
    process.send({odd: {
      r: toGold.r
      g: toGold.g
      b: toGold.b
    }})

  toCardinal.start()
  toGold.start()

  timeout = setTimeout(step2, duration + skip)

step2 = ->
  toCardinal = new RgbTween(Light.hexToRgb(0xffcc00), Light.hexToRgb(0x990000), duration)
  toGold = new RgbTween(Light.hexToRgb(0x990000), Light.hexToRgb(0xffcc00), duration)

  toCardinal.onUpdate =>
    process.send({odd: {
      r: toCardinal.r
      g: toCardinal.g
      b: toCardinal.b
    }})
  toGold.onUpdate =>
    process.send({even: {
      r: toGold.r
      g: toGold.g
      b: toGold.b
    }})

  toCardinal.start()
  toGold.start()

  timeout = setTimeout(step1, duration + skip)

end = ->
  clearTimeout(timeout)

step1()