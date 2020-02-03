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

  fn._setData = function() {
    chfn._setData.apply(this, arguments);
    this._decorateData();
  };

  fn._decorateData = function() {
    var group = _.groupBy(this.data, 'date');

    var odd = false;
    _.each(group, function(entries) {
      _.each(entries, function(entry) {
        entry.odd = odd;
      });
      odd = !odd;
    });
  };

  app.controller('Measurement.IndexController', [
    'cyberhawk_requester', 'cyberhawk_notifier',
    '$location',
    IndexController
  ]);

  Measurement.IndexController = IndexController;

})(window._, window.angular, window.Cyberhawk, window.Measurement);
