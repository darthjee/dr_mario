(function(_, angular, Global) {
  var app = angular.module('global/header_controller', [
    'cyberhawk/notifier',
  ]);

  function Controller(http, notifier, timeout) {
    this.http = http;
    this.notifier = notifier;
    this.timeout = timeout;

    _.bindAll(this, '_login', '_completeLogoff');
    this._listen();
    this._checkLogin();
  }

  var fn = Controller.prototype;

  fn.logoff = function() {
    console.info('logoff');
    this.http.delete('/users/logoff').success(this._completeLogoff);
  };

  fn._listen = function() {
    this.notifier.register('login-success', this._login);
  };

  fn._checkLogin = function() {
    this.http.get('/users/login.json').success(this._login);
  };

  fn._completeLogoff = function() {
    this.user = null;
    this.logged = false;
  };

  fn._login = function(user) {
    var that = this;

    this.timeout(function() {
      that.user = user;
      that.logged = true;
    }, 1);
  };

  app.controller('Global.HeaderController', [
    '$http', 'cyberhawk_notifier', '$timeout',
    Controller
  ]);

  Global.Controller = Controller;
}(window._, window.angular, window.Global));


