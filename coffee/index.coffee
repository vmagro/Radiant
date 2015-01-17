(->
  $(".index-li").addClass "active"

  socket = io.connect("http://localhost:3000")
  socket.on "news", (value) ->
    return  unless value.args and value.address is "/muse/elements/horseshoe"
    frontLeft = value.args[0]
    frontRight = value.args[1]
    leftEar = value.args[2]
    rightEar = value.args[3]

    console.log 'front left: ' + frontLeft
    console.log 'front right: ' + frontRight
    console.log 'left ear: ' + leftEar
    console.log 'right ear: ' + rightEar

)
()