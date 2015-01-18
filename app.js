var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var osc = require('osc');

var socket = require('socket.io');
var express = require('express');
var http = require('http');
var app = express();
app.set('port', process.env.PORT || 3000);
var server = app.listen(app.get('port'));
var io = require('socket.io').listen(server);

var routes = require('./routes/index');
var users = require('./routes/users');
var lights = require('./routes/lights');
var controls = require('./routes/controls');

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(__dirname + '/public/favicon.ico'));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(require('less-middleware')(path.join(__dirname, 'public')));

app.use('/', routes);
app.use('/users', users);
app.use('/lights', lights);
app.use('/controls', controls);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

// error handlers

// development error handler
// will print stacktrace
app.use(function (err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
        message: err.message,
        error: err
    });
});

// production error handler
// no stacktraces leaked to user
//app.use(function (err, req, res, next) {
//    res.status(err.status || 500);
//    res.render('error', {
//        message: err.message,
//        error: {}
//    });
//});

var lastPointTime = Date.now();
var now;

var udpPort = new osc.UDPPort({
    localAddress: "127.0.0.1",
    localPort: 5000
});

udpPort.open();

var Light = require('./lib/light');

io.on('connection', function (socket) {
    console.log("socket.io connection");
    // socket.emit('news', { hello: 'world' });
    // Listen for incoming OSC bundles.
    udpPort.on("message", function (oscData) {
        now = Date.now()
        if ((now - lastPointTime <= 1000) || (lastPointTime - now <= 1000)) {
            lastPointTime = now;
            socket.emit('news', oscData);
        }
    });

    socket.on('light', function (lightData) {
        console.log('got light data from socket');
        for (var i in lightData) {
            if (lightData.hasOwnProperty(i)) {
                console.log('setting color for ' + i);
                Light.lights()[i].setColor(lightData[i]);
            }
        }
    });

});

require('./lib/init-animation').start();
//require('./lib/waiting-animation').start();

module.exports = app;
