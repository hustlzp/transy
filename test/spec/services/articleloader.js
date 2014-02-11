'use strict';

describe('Service: ArticleLoader', function () {

  // load the service's module
  beforeEach(module('transyApp'));

  // instantiate service
  var ArticleLoader;
  beforeEach(inject(function (_ArticleLoader_) {
    ArticleLoader = _ArticleLoader_;
  }));

  it('should do something', function () {
    expect(!!ArticleLoader).toBe(true);
  });

});
