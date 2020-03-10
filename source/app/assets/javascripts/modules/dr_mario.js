(function(angular) {
  var module = angular.module('dr_mario', [
    'global',
    'cyberhawk',
    'kanto',
    'home',
    'measurement',
    'login',
    'filters/time'
  ]);

  module.config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.headers.patch = {
      'Content-Type': 'application/json;charset=utf-8'
    };
  }]);
}(window.angular));
