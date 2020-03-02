(function(_) {
  _.functionWrapper = function(object, method, wrapper) {
    var original = object[method];

    object[method] = function() {
      var binded = _.bind(original, this)
      var args = [binded].concat([].slice.call(arguments, 0));

      return wrapper.apply(this, args);
    };
  };

  class T {
    m() {
      console.info('m');
      return [this, arguments];
    }
  }

  var t = new T();

  _.functionWrapper(t, 'm', function(o, a, b) {
    console.info(arguments);
    console.info('before');
    var r = o(a,b);
    console.info('after');
    return r;
  });

  console.info('call', t.m(1,2));
})(window._);
