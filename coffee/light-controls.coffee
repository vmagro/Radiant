light1 = ko.observable(0x000099)
light2 = ko.observable(0x000099)
light3 = ko.observable(0x000099)
light4 = ko.observable(0x000099)

light1Hex = ko.computed =>
  '#' + ('00000000' + light1().toString(16)).slice(-6)

light2Hex = ko.computed =>
  '#' + ('00000000' + light2().toString(16)).slice(-6)

light3Hex = ko.computed =>
  '#' + ('00000000' + light3().toString(16)).slice(-6)

light4Hex = ko.computed =>
  '#' + ('00000000' + light4().toString(16)).slice(-6)

lightObservables = [light1, light2, light3, light4]

onChangeFor = (pickerNum) ->
  return (container, color) ->
    data = {}
    data[pickerNum] = parseInt(color.tiny.toHex(), 16)
    io().emit('light', data)
    if($('#lights-linked').prop('checked'))
      for obs in lightObservables
        obs(parseInt(color.tiny.toHex(), 16))

subscribeFor = (pickerNum) ->
  return (value) ->
    $('#picker' + (pickerNum + 1)).trigger('colorpickersliders.updateColor', '#' + value.toString(16))

light1.subscribe(subscribeFor(0))
light2.subscribe(subscribeFor(1))
light3.subscribe(subscribeFor(2))
light4.subscribe(subscribeFor(3))

io().on('light', (data) ->
  for num, color in data
    lightObservables[num] = color
)

(->
  $(".controls-li").addClass "active"
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
    onchange: onChangeFor(3))()