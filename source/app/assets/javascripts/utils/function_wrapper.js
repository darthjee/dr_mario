(function(_) {
  class FunctionWrapper {
    constructor(object, method, wrapper) {
      this.object = object;
      this.method = method;
      this.wrapper = wrapper;
      this.original = object[method];
    }

    wrap() {
      var that = this;
      
      return function() {
        var binded = _.bind(that.original, this)
        var args = [binded].concat([].slice.call(arguments, 0));

        return that.wrapper.apply(this, args);
      };
    }

    bindedWrap() {
      var that = this;
      
      return function() {
        var binded = that._bind(that.original, this, arguments)
        var args = [binded].concat([].slice.call(arguments, 0));

        return that.wrapper.apply(this, args);
      };
    }

    _bind(func, caller, args) {
      return function() {
        return func.apply(caller, args);
      };
    }
  }

  _.functionWrapper = function(object, method, wrapper) {
    var wrapper = new FunctionWrapper(object, method, wrapper);

    object[method] = wrapper.bindedWrap();
  };

  class T {
    m() {
      console.info('m');
      console.info(arguments);
      return this;
    }
  }

  var t = new T();

  _.functionWrapper(t, 'm', function(o) {
    console.info(arguments);
    console.info('before');
    var r = o();
    console.info('after');
    return r;
  });

  console.info('call', t.m(1,2));
})(window._);
