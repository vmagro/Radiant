var DMX, Light, dmx, universe;

DMX = require('dmx');

dmx = new DMX();

universe = dmx.addUniverse('demo', 'enttec-usb-dmx-pro', 0);

Light = (function() {
  function Light(num) {
    this.num = num;
    this.channelR = this.num * 4 + 1;
    this.channelG = this.channelR + 1;
    this.channelB = this.channelG + 1;
  }

  Light.prototype.setColor = function(hex) {
    var channels, rgb;
    rgb = this.hexToRgb(hex);
    channels = {};
    channels[this.channelR] = rgb.r;
    channels[this.channelG] = rgb.g;
    channels[this.channelB] = rgb.b;
    return universe.update(channels);
  };

  Light.prototype.hexToRgb = function(hex) {
    return {
      r: hex >> 16,
      g: hex >> 8 & 0xFF,
      b: hex & 0xFF
    };
  };

  return Light;

})();

module.exports = Light;
