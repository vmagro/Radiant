var frontLeft, frontRight, leftEar, rightEar, sensor_status;

frontLeft = ko.observable(4);

frontRight = ko.observable(4);

leftEar = ko.observable(4);

rightEar = ko.observable(4);

(sensor_status = function() {
  var socket;
  $(".index-li").addClass("active");
  socket = io.connect(window.location.hostname);
  return socket.on("news", function(value) {
    if (!(value.args && value.address === "/muse/elements/horseshoe")) {
      return;
    }
    this.frontLeft = value.args[1];
    this.frontRight = value.args[2];
    this.leftEar = value.args[0];
    this.rightEar = value.args[3];
    console.log('front left: ' + frontLeft);
    console.log('front right: ' + frontRight);
    console.log('left ear: ' + leftEar);
    return console.log('right ear: ' + rightEar);
  });
})();
