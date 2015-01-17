do sensor_status = ->
  @frontLeft = ko.observable 4
  @frontRight = ko.observable 4
  @leftEar = ko.observable 4
  @rightEar = ko.observable 4

  $(".index-li").addClass "active"

  socket = io.connect(window.location.hostname)
  socket.on "news", (value) ->
    return  unless value.args and value.address is "/muse/elements/horseshoe"
    @frontLeft = value.args[1]
    @frontRight = value.args[2]
    @leftEar = value.args[0]
    @rightEar = value.args[3]

    console.log 'front left: ' + frontLeft
    console.log 'front right: ' + frontRight
    console.log 'left ear: ' + leftEar
    console.log 'right ear: ' + rightEar
