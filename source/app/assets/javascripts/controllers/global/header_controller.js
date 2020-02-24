(function(_, angular, Global) {
  var app = angular.module('global/header_controller', [
    'cyberhawk/notifier',
  ]);

  function Controller(notifier, interval) {
    this.notifier = notifier;
    this.interval = interval;

    _.bindAll(this, '_login');
    this._listen();
  }

  var fn = Controller.prototype;

  fn._listen = function() {
    this.notifier.register('login-success', this._login)
  };

  fn._login = function(user) {
    var that = this;

    this.interval(function() {
      that.user = user;
      that.logged = true;
    }, 1);
  };

  app.controller('Global.HeaderController', [
    'cyberhawk_notifier', '$interval',
    Controller
  ]);

  Global.Controller = Controller;
}(window._, window.angular, window.Global));


