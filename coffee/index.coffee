do sensor_status = ->
  $(".index-li").addClass "active"

  window.app = new App()
  ko.applyBindings app

  $(".index-li").click ->
    $(this).addClass "active"
    $(".controls-li").removeClass "active"
    $("#index").removeClass "hidden"
    $("#controls").addClass "hidden"

  socket = io.connect(window.location.hostname)
  socket.on "news", (value) ->
    if value.args and value.address is "/muse/elements/horseshoe"
      app.leftEar value.args[0]
      app.frontLeft value.args[1]
      app.frontRight value.args[2]
      app.rightEar value.args[3]

      console.log 'front left: ' + value.args[1]
      console.log 'front right: ' + value.args[2]
      console.log 'left ear: ' + value.args[0]
      console.log 'right ear: ' + value.args[3]

    if value.args and value.address is "/muse/elements/experimental/concentration"
      app.concentrationGraphData.shift()
      app.concentrationGraphData(for elem in app.concentrationGraphData()
          elem = [elem[0] - 1, elem[1]]
      )
      app.concentrationGraphData.push([app.concentrationGraphData().length, value.args[0]])

    if value.args and value.address is "/muse/elements/experimental/mellow"
      app.mellowGraphData.shift()
      app.mellowGraphData(for elem in app.mellowGraphData()
          elem = [elem[0] - 1, elem[1]]
      )
      app.mellowGraphData.push([app.mellowGraphData().length, value.args[0]])


$(document).ready(() ->
  for i in [0...200]
    app.mellowGraphData.push([i, 0])

  plot = $.plot("#mellow-graph", [app.mellowGraphData()],
    series:
      shadowSize: 0 # Drawing is faster without shadows

    yaxis:
      min: 0
      max: 100

    xaxis:
      show: false
  )
  app.mellowGraphData.subscribe (data) ->
    plot.setData [data]
    plot.draw()
    return

  setInterval(() ->
    app.mellowGraphData.shift()
    app.mellowGraphData(for elem in app.mellowGraphData()
        elem = [elem[0] - 1, elem[1]]
    )
    app.mellowGraphData.push([app.mellowGraphData().length, Math.round(Math.random() * 100)])
  , 50)
)

$(document).ready(() ->
  for i in [0...200]
    app.concentrationGraphData.push([i, 0])

  plot = $.plot("#concentration-graph", [app.concentrationGraphData()],
    series:
      shadowSize: 0 # Drawing is faster without shadows

    yaxis:
      min: 0
      max: 100

    xaxis:
      show: false
  )
  app.concentrationGraphData.subscribe (data) ->
    plot.setData [data]
    plot.draw()
    return

  setInterval(() ->
    app.concentrationGraphData.shift()
    app.concentrationGraphData(for elem in app.concentrationGraphData()
        elem = [elem[0] - 1, elem[1]]
    )
    app.concentrationGraphData.push([app.concentrationGraphData().length, Math.round(Math.random() * 100)])
  , 50)
)