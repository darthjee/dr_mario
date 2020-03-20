(function(_, angular, $) {
  var app = angular.module('users/controller', [
    'binded_http'
  ]);

  function Controller(bindedHttp) {
    this.http = bindedHttp.bind(this);

    _.bindAll(this, '_success', '_request');
    this._init();
  }

  var fn = Controller.prototype;

  fn._init = function() {
    this._request().success(this._success);
  };

  fn._request = function() {
    return this.http.get('/users.json');
  }

  fn._success = function(data) {
    this.users = data;
  };

  fn.initRequest = function() {
    this.ongoing = true;
  };

  fn.finishRequest = function() {
    this.ongoing = false;
  };

  app.controller('User.Controller', [
    'binded_http',
    Controller
  ]);
}(window._, window.angular, window.$));


