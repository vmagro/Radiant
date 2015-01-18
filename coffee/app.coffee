class App
  constructor: ->
    @frontLeft = ko.observable 4
    @frontRight = ko.observable 4
    @leftEar = ko.observable 4
    @rightEar = ko.observable 4
    @mellowGraphData = ko.observableArray()
    @concentrationGraphData = ko.observableArray()

    @light1 = ko.observable(0x000099)
    @light2 = ko.observable(0x000099)
    @light3 = ko.observable(0x000099)
    @light4 = ko.observable(0x000099)

    @light1Hex = ko.computed =>
      '#' + ('00000000' + @light1().toString(16)).slice(-6)

    @light2Hex = ko.computed =>
      '#' + ('00000000' + @light2().toString(16)).slice(-6)

    @light3Hex = ko.computed =>
      '#' + ('00000000' + @light3().toString(16)).slice(-6)

    @light4Hex = ko.computed =>
      '#' + ('00000000' + @light4().toString(16)).slice(-6)