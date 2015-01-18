do lights = ->
  lightObservables = [app.light1, app.light2, app.light3, app.light4]

  onChangeFor = (pickerNum) ->
    return (container, color) ->
      data = {}
      data[pickerNum] = parseInt(color.tiny.toHex(), 16)
      io().emit('light', data)
      if($('#lights-linked').prop('checked'))
        for i in [1..4]
          $('#picker'+i).trigger('colorpickersliders.updateColor', color.tiny.toHex())
        for obs in lightObservables
          obs(parseInt(color.tiny.toHex(), 16))
      else
        lightObservables[pickerNum](parseInt(color.tiny.toHex(), 16))

  io().on('light', (data) ->
    for i of data
      if data.hasOwnProperty(i)
        lightObservables[i](data[i])
  )

  $(".controls-li").click ->
    $(this).addClass "active"
    $(".index-li").removeClass "active"
    $("#controls").removeClass "hidden"
    $("#index").addClass "hidden"

  $("#picker1").ColorPickerSliders
    color: "#000099"
    flat: true
    sliders: false
    swatches: false
    hsvpanel: true
    onchange: onChangeFor(0)

  $("#picker2").ColorPickerSliders
    color: "#000099"
    flat: true
    sliders: false
    swatches: false
    hsvpanel: true
    onchange: onChangeFor(1)

  $("#picker3").ColorPickerSliders
    color: "#000099"
    flat: true
    sliders: false
    swatches: false
    hsvpanel: true
    onchange: onChangeFor(2)

  $("#picker4").ColorPickerSliders
    color: "#000099"
    flat: true
    sliders: false
    swatches: false
    hsvpanel: true
    onchange: onChangeFor(3)