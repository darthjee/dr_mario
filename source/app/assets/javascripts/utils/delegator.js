(function(_) {
  class Delegator {
    constructor(caller, objectName) {
      this.caller = caller;
      this.objectName = objectName;
      _.bindAll(this, 'delegate');
    }

    delegate(method) {
      var objectName = this.objectName;

      this.caller.prototype[method] = function() {
        return this[objectName][method](arguments);
      };
    };
  }

  _.delegate = function(caller, object) {
    var methods = [].slice.call(arguments, 2),
      fn =  caller.prototype,
      delegator = new Delegator(caller, object);

    _.each(methods, delegator.delegate);

  }

  function T(obj) {
    this.obj = obj;
  }

  _.delegate(T, 'obj', 'a');

  t = new T({ a: function() { return 1 } });

  console.info(t.a());
})(window._);
