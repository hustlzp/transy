// Generated by CoffeeScript 1.6.1
(function() {
  var a, b, f, x,
    __slice = [].slice;

  a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  b = (function() {
    var _i, _len, _results;
    _results = [];
    for (_i = 0, _len = a.length; _i < _len; _i++) {
      x = a[_i];
      _results.push(x * x);
    }
    return _results;
  })();

  console.log(b);

  f = function() {
    var a, b;
    a = arguments[0], b = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return a + b;
  };

}).call(this);