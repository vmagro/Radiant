
do sensor_status = ->
  $(".index-li").addClass "active"
  
  window.app = new App()
  ko.applyBindings app

  socket = io.connect(window.location.hostname)
  socket.on "news", (value) ->
    return  unless value.args and value.address is "/muse/elements/horseshoe"
    app.leftEar value.args[0]
    app.frontLeft value.args[1]
    app.frontRight value.args[2]
    app.rightEar value.args[3]

    console.log 'front left: ' + value.args[1]
    console.log 'front right: ' + value.args[2]
    console.log 'left ear: ' + value.args[0]
    console.log 'right ear: ' + value.args[3]
