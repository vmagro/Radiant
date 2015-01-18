path = require("path")
favicon = require("serve-favicon")
logger = require("morgan")
cookieParser = require("cookie-parser")
bodyParser = require("body-parser")
osc = require("osc")
socket = require("socket.io")
express = require("express")
http = require("http")
app = express()
app.set "port", process.env.PORT or 3000
server = app.listen(app.get("port"))
io = require("socket.io").listen(server)
routes = require("./routes/index")
users = require("./routes/users")
lights = require("./routes/lights")
controls = require("./routes/controls")

# view engine setup
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

# uncomment after placing your favicon in /public
#app.use(favicon(__dirname + '/public/favicon.ico'));
app.use logger("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
app.use express.static(path.join(__dirname, "public"))
app.use require("less-middleware")(path.join(__dirname, "public"))
app.use "/", routes
app.use "/users", users
app.use "/lights", lights
app.use "/controls", controls

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error("Not Found")
  err.status = 404
  next err
  return


# error handlers

# development error handler
# will print stacktrace
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render "error",
    message: err.message
    error: err

  return


# production error handler
# no stacktraces leaked to user
#app.use(function (err, req, res, next) {
#    res.status(err.status || 500);
#    res.render('error', {
#        message: err.message,
#        error: {}
#    });
#});

Light = require('./lib/light');

lights = [];
for num in [0...4]
  lights.push new Light num

lastPointTime = Date.now()
now = undefined

udpPort = new osc.UDPPort(
  localAddress: "127.0.0.1"
  localPort: 5000
)
udpPort.open()

standby = require("./lib/standby-animation")
standby.start()

chroma = require('chroma-js')

io.on "connection", (socket) ->
  console.log "socket.io connection"

  # socket.emit('news', { hello: 'world' });
  # Listen for incoming OSC bundles.
  udpPort.on "message", (oscData) ->
    now = Date.now()
    if (now - lastPointTime <= 1000) or (lastPointTime - now <= 1000)
      lastPointTime = now
      socket.emit "news", oscData

    if oscData.args and oscData.address is "/muse/elements/experimental/concentration"
      scale = chroma.scale(['blue', 'red'])
      color = scale(oscData.args[0])
      color = (color._rgb[0] << 16) + (color._rgb[1] << 8) + color._rgb[2];
      Light.setAll(color)

      lightVals = {}
      for i in [0...4]
        lightVals[i] = parseInt(Light.lights()[i].getColor().substring(2), 16)
        i++
      socket.emit "light", lightVals

  socket.on "light", (lightData) ->
    console.log "got light data from socket"
    waiting.end()
    for i of lightData
      if lightData.hasOwnProperty(i)
        console.log "setting color for " + i + " -> " + lightData[i].toString(16)
        Light.lights()[i].setColorImmediately Light.hexToRgb(lightData[i])


    lightVals = {}
    for i in [0...4]
      lightVals[i] = parseInt(Light.lights()[i].getColor().substring(2), 16)
      i++
    socket.emit "light", lightVals
    return

  return

#require('./lib/waiting-animation').start();
module.exports = app