var sensor_status;

(sensor_status = function() {
  var socket;
  $(".index-li").addClass("active");
  window.app = new App();
  ko.applyBindings(app);
  socket = io.connect(window.location.hostname);
  return socket.on("news", function(value) {
    if (!(value.args && value.address === "/muse/elements/horseshoe")) {
      return;
    }
    app.leftEar(value.args[0]);
    app.frontLeft(value.args[1]);
    app.frontRight(value.args[2]);
    app.rightEar(value.args[3]);
    console.log('front left: ' + value.args[1]);
    console.log('front right: ' + value.args[2]);
    console.log('left ear: ' + value.args[0]);
    return console.log('right ear: ' + value.args[3]);
  });
})();
