(function(_, angular) {
  var module = angular.module('binded_http', []);

  class BindedHttpService {
    constructor($http) {
      this.http = $http;
    }

    bind(controller) {
      this.controller = controller;
      return this;
    }
  }

  _.delegate(BindedHttpService, 'http', 'get', 'post');

  function BindedHttpServiceFactory($http) {
    return new BindedHttpService($http);
  }

  module.service('binded_http', [
    '$http',
    BindedHttpServiceFactory
  ])
}(window._, window.angular));


