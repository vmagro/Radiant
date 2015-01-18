do sensor_status = ->
  $(".index-li").addClass "active"

  window.app = new App()
  ko.applyBindings app
  mellowIncrement = 0
  concentrationIncrement = 0

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
      app.concentrationGraphData.push([concentrationIncrement++, value.args[0]])

    if value.args and value.address is "/muse/elements/experimental/mellow"
      app.mellowGraphData.push([mellowIncrement++, value.args[0]])


$(document).ready(() ->
  app.mellowGraphData.push(
    [1, 5], [2, 5], [3, 5], [4, 5], [5, 5], [6, 5], [7, 5], [8, 5], [9, 5], [10, 5]
  )

  plot = $.plot('#mellow-graph', [ app.mellowGraphData() ],
    series:
      shadowSize: 0

    xaxis:
      show: false

    yaxis:
      min: 0
      max: 110
  )

  app.mellowGraphData.subscribe(() ->
    plot.setData [ app.mellowGraphData() ]
    plot.draw()
  )

  plot.draw()

  setInterval(() ->
    app.mellowGraphData.shift()
    app.mellowGraphData(for elem in app.mellowGraphData()
        elem = [elem[0] - 1, elem[1]]
    )
    app.mellowGraphData.push([app.mellowGraphData().length, Math.round(Math.random() * 100)])
  , 50)
)