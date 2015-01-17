express = require('express');
router = express.Router();

Light = require('../lib/light');

lights = [];
for num in [0..4]
  lights.push new Light num
  lights[num].setColor 0x000055 # default to a dim blue color

router.get('/', (req, res, next) ->
  lightValues = {}
  for light, num in lights
    lightValues[num] = light.getColor()

  console.log lightValues
  res.status 200
  res.json lightValues
  res.end()
)

module.exports = router;
