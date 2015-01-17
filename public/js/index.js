var sensor_status;

(sensor_status = function() {
  var ko, socket;
  $(".index-li").addClass("active");
  socket = io.connect(window.location.hostname);
  return socket.on("news", value);
})();
