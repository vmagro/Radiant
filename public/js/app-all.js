var App;

App = (function() {
  function App() {
    this.frontLeft = ko.observable(4);
    this.frontRight = ko.observable(4);
    this.leftEar = ko.observable(4);
    this.rightEar = ko.observable(4);
    this.frontLeftRed = ko.computed((function(_this) {
      return function() {
        return _this.frontLeft() >= 3;
      };
    })(this));
    this.frontLeftYellow = ko.computed((function(_this) {
      return function() {
        return _this.frontLeft() === 2;
      };
    })(this));
    this.rontLeftGreen = ko.computed((function(_this) {
      return function() {
        return _this.frontLeft() === 1;
      };
    })(this));
  }

  return App;

})();
