(function(_, angular) {
  var module = angular.module('binded_http', []);

  function BindedHttpServiceFactory() {
    return new BindedHttpService();
  }

  class BindedHttpService {
    bind: function(controller) {
      this.controller = controller;
    }
  }

  module.service('binded_http', [BindedHttpServiceFactory])
}(window._, window.angular));


