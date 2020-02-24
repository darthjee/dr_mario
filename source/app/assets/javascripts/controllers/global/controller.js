(function(_, angular, Global) {
  var app = angular.module('global/controller', [
    'cyberhawk/notifier',
  ]);

  function Controller(notifier) {
    this.notifier = notifier;

    this._listen();
  }

  var fn = Controller.prototype;

  fn._listen = function() {
    this.notifier.register('login-success', this._login)
  };

  fn._login = function(user) {
    this.user = user;
    this.logged = true;
  };

  app.controller('Global.Controller', [
    'cyberhawk_notifier', Controller
  ]);

  Global.Controller = Controller;
}(window._, window.angular, window.Global));

