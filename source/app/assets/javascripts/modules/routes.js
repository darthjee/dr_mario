(function(angular) {
  var module = angular.module('dr_mario');

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
        controller: 'Measurement.FormController',
        controllerAs: 'mc'
      }
    }, {
      routes: [
        '/users/:user_id/measurements'
      ],
      config: {
        controller: 'Measurement.IndexController',
        controllerAs: 'mc'
      }
    },{
      routes: []
    }];
    provider.$get().bindRoutes();
  }]);
}(window.angular));

