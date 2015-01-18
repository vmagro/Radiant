var App;

App = (function() {
  function App() {
    this.frontLeft = ko.observable(4);
    this.frontRight = ko.observable(4);
    this.leftEar = ko.observable(4);
    this.rightEar = ko.observable(4);
    this.mellowGraphData = ko.observableArray();
    this.concentrationGraphData = ko.observableArray();
    this.light1 = ko.observable(0x000099);
    this.light2 = ko.observable(0x000099);
    this.light3 = ko.observable(0x000099);
    this.light4 = ko.observable(0x000099);
    this.light1Hex = ko.computed((function(_this) {
      return function() {
        return '#' + ('00000000' + _this.light1().toString(16)).slice(-6);
      };
    })(this));
    this.light2Hex = ko.computed((function(_this) {
      return function() {
        return '#' + ('00000000' + _this.light2().toString(16)).slice(-6);
      };
    })(this));
    this.light3Hex = ko.computed((function(_this) {
      return function() {
        return '#' + ('00000000' + _this.light3().toString(16)).slice(-6);
      };
    })(this));
    this.light4Hex = ko.computed((function(_this) {
      return function() {
        return '#' + ('00000000' + _this.light4().toString(16)).slice(-6);
      };
    })(this));
  }

  return App;

})();
