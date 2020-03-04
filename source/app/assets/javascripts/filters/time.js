(function(_, angular) {
  var module = angular.module('filters/time', []);

  function FilterFactory() {
  }

  console.info('filter',module.filter('time', [
    FilterFactory
  ]);
}(window._, window.angular));



