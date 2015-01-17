var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function (req, res, next) {
    res.render('controls', {title: 'Radiance'});
});

module.exports = router;