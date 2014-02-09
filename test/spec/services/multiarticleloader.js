'use strict';

describe('Service: MultiArticleLoader', function () {

  // load the service's module
  beforeEach(module('transyApp'));

  // instantiate service
  var MultiArticleLoader;
  beforeEach(inject(function (_MultiArticleLoader_) {
    MultiArticleLoader = _MultiArticleLoader_;
  }));

  it('should do something', function () {
    expect(!!MultiArticleLoader).toBe(true);
  });

});
