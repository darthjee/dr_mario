(function(_) {
  class FunctionWrapper {
    constructor(object, method, wrapper) {
      this.object = object;
      this.method = method;
      this.wrapper = wrapper;
      this.original = object[method];
    }

    wrap(bindArguments) {
      var that = this;
      
      return function() {
        var binded = that._bind(that.original, this, arguments, bindArguments);
        var args = [binded].concat([].slice.call(arguments, 0));

        return that.wrapper.apply(this, args);
      };
    }

    _bind(func, caller, args, bindArguments) {
      if (bindArguments) {
        return function() {
          return func.apply(caller, args);
        };
      } else {
        return _.bind(func, caller);
      }
    }
  }

  _.functionWrapper = function(object, method, wrapper) {
    var wrapper = new FunctionWrapper(object, method, wrapper);

    object[method] = wrapper.wrap();
  };

  class T {
    m() {
      console.info('m');
      console.info(arguments);
      return this;
    }
  }

  var t = new T();

  _.functionWrapper(t, 'm', function(o, a, b) {
    console.info(arguments);
    console.info('before');
    var r = o(a, b, 3);
    console.info('after');
    return r;
  });

  console.info('call', t.m(1,2));
})(window._);
