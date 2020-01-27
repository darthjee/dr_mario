(function(angular) {
  var module = angular.module('dr_mario', [
    'global',
    'cyberhawk',
    'kanto',
    'home',
    'measurement'
  ]);

  module.config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.headers.patch = {
      'Content-Type': 'application/json;charset=utf-8'
    };
  }]);

  module.config(['kantoProvider', function(provider) {
    provider.defaultConfig = {
      controller: 'Cyberhawk.Controller',
      controllerAs: 'gnc',
      templateBuilder: function(route, params) {
        return route + '?ajax=true';
      }
    }

    provider.configs = [{
      routes: ['/'],
      config: {
        controller: 'Home.Controller',
        controllerAs: 'hc'
      }
    }, {
      routes: [
        '/users/:user_id/measurements/new'
      ],
      config: {
        controller: 'Measurement.Controller',
        controllerAs: 'mc'
      }
    },{
      routes: [
        '/users/:user_id/measurements'
      ]
    }];
    provider.$get().bindRoutes();
  }]);
}(window.angular));
