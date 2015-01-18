class App
  constructor: ->
    @frontLeft = ko.observable 4
    @frontRight = ko.observable 4
    @leftEar = ko.observable 4
    @rightEar = ko.observable 4
    @mellowGraphData = ko.observableArray()
    @concentrationGraphData = ko.observableArray()
