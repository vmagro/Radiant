var sensor_status;

(sensor_status = function() {
  var socket;
  $(".index-li").addClass("active");
  socket = io.connect(window.location.hostname);
  return socket.on("news", function(value) {
    var frontLeft, frontRight, leftEar, rightEar;
    if (!(value.args && value.address === "/muse/elements/horseshoe")) {
      return;
    }
    frontLeft = value.args[0];
    frontRight = value.args[1];
    leftEar = value.args[2];
    rightEar = value.args[3];
    console.log('front left: ' + frontLeft);
    console.log('front right: ' + frontRight);
    console.log('left ear: ' + leftEar);
    return console.log('right ear: ' + rightEar);
  });
})();
