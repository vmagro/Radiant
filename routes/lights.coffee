express = require('express');
router = express.Router();

router.get('/', (req, res) ->
  lightValues = {}
  for light, num in lights
    lightValues[num] = light.getColor()

  console.log lightValues
  res.status 200
  res.json lightValues
  res.end()
)

router.post('/:id', (req, res) ->
  lights[req.params.id].setColor req.body.color

  res.status 200
  res.end()
)

router.post('/', (req, res) ->
  for light in lights
    light.setColor req.body.color

  res.status 200
  res.end()
)

module.exports = router;
