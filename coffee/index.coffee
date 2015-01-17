
do sensor_status = ->
  $(".index-li").addClass "active"
  
  window.app = new App()
  ko.applyBindings app

  socket = io.connect(window.location.hostname)
  socket.on "news", (value) ->
    return  unless value.args and value.address is "/muse/elements/horseshoe"
    @leftEar(value.args[0])
    @frontLeft(value.args[1])
    @frontRight(value.args[2])
    @rightEar(value.args[3])

    console.log 'front left: ' + @frontLeft
    console.log 'front right: ' + @frontRight
    console.log 'left ear: ' + @leftEar
    console.log 'right ear: ' + @rightEar
