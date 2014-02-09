'use strict';

describe('Service: Article', function () {

  // load the service's module
  beforeEach(module('transyApp'));

  // instantiate service
  var Article;
  beforeEach(inject(function (_Article_) {
    Article = _Article_;
  }));

  it('should do something', function () {
    expect(!!Article).toBe(true);
  });

});
