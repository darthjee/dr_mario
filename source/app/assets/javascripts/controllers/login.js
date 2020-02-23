(function(_, angular) {
  var app = angular.module('login/controller', [
    'cyberhawk/controller',
    'cyberhawk/notifier',
  ]);


  function Controller(http, notifier) {
    this.http     = http;
    this.notifier = notifier;
    console.info(this);
    window.d = this;
  }

  var fn = Controller.prototype;

  fn.submit = function() {
    console.info('click');
    console.info(this.login);
    console.info(this.password);
  };

  app.controller('Login.Controller', [
    '$http', 'cyberhawk_notifier',
    Controller
  ]);
}(window._, window.angular));

