(function(_, angular, $) {
  var app = angular.module('login/controller', [
    'cyberhawk/controller',
    'cyberhawk/notifier',
    'binded_http'
  ]);


  function Controller(http, notifier, bindedHttp) {
    this.http     = http;
    this.notifier = notifier;

    bindedHttp.bind(this);

    _.bindAll(this, '_success', '_error');
  }

  var fn = Controller.prototype;

  fn.submit = function() {
    this._request()
      .success(this._success)
      .error(this._error);
  };

  fn._request = function() {
    return this.http.post('/users/login', {
      login: {
        login: this.login,
        password: this.password
      }
    });
  }

  fn._success = function(user) {
    this.notifier.notify('login-success', user);
    this.incorrect = false
    $('#login-modal').modal('hide');
  };

  fn._error = function(_body, status) {
    this.notifier.notify('login-errror', {
      status: status
    });
    if (status / 100 == 4) {
      this.incorrect = true
    } else {
      this.error = true
    }
  };

  app.controller('Login.Controller', [
    '$http', 'cyberhawk_notifier', 'binded_http',
    Controller
  ]);
}(window._, window.angular, window.$));

