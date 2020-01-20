(function(_, angular, Cyberhawk, Measurement) {
  function Controller(builder, notifier, $location, $interval) {
    this.construct(builder.build($location), notifier, $location, $interval);
  }

  var fn = Controller.prototype,
      chfn = Cyberhawk.Controller.prototype,
      app = angular.module('measurement/controller', [
        'cyberhawk/notifier', 'cyberhawk/requester'
      ]);

  _.extend(fn, Cyberhawk.Controller.prototype);

  fn.construct = function(requester, notifier, $location, $interval) {
    this.autoUpdate = true;
    this.$interval = $interval;
    _.bindAll(this, '_updateTime');
    chfn.construct.apply(this, arguments);
  };

  fn._setData = function() {
    chfn._setData.apply(this, arguments);
    this.toggleClock();
  };

  fn.toggleClock = function() {
    if(this.autoUpdate) {
      this._startClock();
    } else {
      this._stopClock();
    }
  };

  fn._startClock = function() {
    this._updateTime();
    this.clockTrack = this.$interval(this._updateTime, 1000);
  };

  fn._stopClock = function() {
    if (this.clockTrack) {
      this.$interval.cancel(this.clockTrack);
      this.clockTrack = null;
    }
  };

  fn._updateTime = function() {
    var date = new Date();
    this.data.date = [
      date.getFullYear(),
      date.getMonth() + 1,
      date.getDate(),
    ].join("-").replace(/\b(\d)\b/g, "0$1")
    this.data.time = [
      date.getHours(),
      date.getMinutes(),
      date.getSeconds()
    ].join(":").replace(/\b(\d)\b/g, "0$1")
  };

  app.controller('Measurement.Controller', [
    'cyberhawk_requester', 'cyberhawk_notifier',
    '$location', '$interval',
    Controller
  ]);

  Measurement.Controller = Controller;

})(window._, window.angular, window.Cyberhawk, window.Measurement);
