(function(_, angular, Cyberhawk, Measurement) {
  function IndexController(builder, notifier, $location) {
    this.construct(builder.build($location), notifier, $location);
  }

  var fn = IndexController.prototype,
      chfn = Cyberhawk.Controller.prototype,
      app = angular.module('measurement/index_controller', [
        'cyberhawk/notifier', 'cyberhawk/requester'
      ]);

  _.extend(fn, Cyberhawk.Controller.prototype);

  fn.construct = function(requester, notifier, $location) {
    chfn.construct.apply(this, arguments);
  };

  app.controller('Measurement.IndexController', [
    'cyberhawk_requester', 'cyberhawk_notifier',
    '$location',
    IndexController
  ]);

  Measurement.IndexController = IndexController;

})(window._, window.angular, window.Cyberhawk, window.Measurement);
