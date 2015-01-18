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


do mellow_chart = ->
  container = $("#mellow-graph")

  app.mellowGraphData.push(
    [1, 5], [2, 10], [3, 20], [4, 30]
  )

  series = [
    data: app.mellowGraphData()
    lines:
      fill: true
  ]

  plot = $.plot(container, series,
    grid:
      borderWidth: 1
      minBorderMargin: 20
      labelMargin: 10
      backgroundColor:
        colors: ["#fff", "#e4f4f4"]

      margin:
        top: 8
        bottom: 20
        left: 20

      markings: (axes) ->
        markings = []
        xaxis = axes.xaxis
        x = Math.floor(xaxis.min)

        while x < xaxis.max
          markings.push
            xaxis:
              from: x
              to: x + xaxis.tickSize

            color: "rgba(232, 232, 255, 0.2)"

          x += xaxis.tickSize * 2
        markings

    xaxis:
      tickFormatter: ->
        ""

    yaxis:
      min: 0
      max: 110

    legend:
      show: true
  )

  app.mellowGraphData.subscribe =>
    console.log 'mellow ' + app.mellowGraphData()
    series[0].data = app.mellowGraphData()
    plot.setData series
    plot.draw()

  plot.draw()


do concentration_chart = ->
  container = $("#concentration-graph")

  app.concentrationGraphData.push([
      [1, 5], [2, 10], [3, 20], [4, 30]]
  )

  series = [
    data: app.concentrationGraphData()
    lines:
      fill: true
  ]

  plot = $.plot(container, series,
    grid:
      borderWidth: 1
      minBorderMargin: 20
      labelMargin: 10
      backgroundColor:
        colors: ["#fff", "#e4f4f4"]

      margin:
        top: 8
        bottom: 20
        left: 20

      markings: (axes) ->
        markings = []
        xaxis = axes.xaxis
        x = Math.floor(xaxis.min)

        while x < xaxis.max
          markings.push
            xaxis:
              from: x
              to: x + xaxis.tickSize

            color: "rgba(232, 232, 255, 0.2)"

          x += xaxis.tickSize * 2
        markings

    xaxis:
      tickFormatter: ->
        ""

    yaxis:
      min: 0
      max: 110

    legend:
      show: true
  )

  app.concentrationGraphData.subscribe =>
    console.log 'concentration ' + app.concentrationGraphData()
    series[0].data = app.concentrationGraphData()
    plot.setData series
    plot.draw()

  plot.draw()


