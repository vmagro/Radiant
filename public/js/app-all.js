var App;

App = (function() {
  function App() {
    this.frontLeft = ko.observable(4);
    this.frontRight = ko.observable(4);
    this.leftEar = ko.observable(4);
    this.rightEar = ko.observable(4);
    this.mellowGraphData = ko.observableArray();
    this.concentrationGraphData = ko.observableArray();
  }

  return App;

})();
