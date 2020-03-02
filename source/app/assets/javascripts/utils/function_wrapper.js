(function(_) {
  class FunctionWrapper {
    constructor(object, method, wrapper) {
      this.object = object
      this.method = method
      this.wrapper = wrapper
      this.original = object[method]
    }

    build() {
      var that = this;
      
      return function() {
        var binded = _.bind(that.original, this)
        var args = [binded].concat([].slice.call(arguments, 0));

        return that.wrapper.apply(this, args);
      };
    }
  }

  _.functionWrapper = function(object, method, wrapper) {
    var wrapper = new FunctionWrapper(object, method, wrapper);

    object[method] = wrapper.build();
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
