(function(_, angular) {
  var module = angular.module('filters/time', []);

  function FilterFactory() {
    return function(timeString) {
      return timeString
        .replace(/[^T]*T/, '')
        .replace(/\..*/, "");
    };
  }

  module.filter('time', [
    FilterFactory
  ]);
}(window._, window.angular));
