(function(_, angular) {
  var module = angular.module('binded_http', []);

  class BindedHttpService {
    constructor($http) {
      this.http = $http;
    }

    bind(controller) {
      this.controller = controller;
    }
  }

  function BindedHttpServiceFactory($http) {
    return new BindedHttpService($http);
  }

  module.service('binded_http', [
    '$http',
    BindedHttpServiceFactory
  ])
}(window._, window.angular));


