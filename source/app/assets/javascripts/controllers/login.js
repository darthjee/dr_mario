(function(_, angular) {
  var app = angular.module('login/controller', [
    'cyberhawk/controller',
    'cyberhawk/notifier',
  ]);


  function Controller(http, notifier) {
    this.http     = http;
    this.notifier = notifier;

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
  };

  fn._error = function(_body, status) {
    this.notifier.notify('login-errror', {
      status: status
    });
  };

  app.controller('Login.Controller', [
    '$http', 'cyberhawk_notifier',
    Controller
  ]);
}(window._, window.angular));

