'use strict';

describe('Service: MultiArticleLoader', function () {

  // load the service's module
  beforeEach(module('transyApp'));

  // instantiate service
  var articles, multiArticleLoader, mockBackend;
  beforeEach(inject(function (_MultiArticleLoader_, _$httpBackend_) {
    var url = 'http://localhost:3000/article';
    multiArticleLoader = _MultiArticleLoader_;
    mockBackend = _$httpBackend_;
    mockBackend.expectGET(url).respond([{'enTitle': 'title1'}, {'enTitle': 'title2'}]);
  }));

  it('should fetch the correct articles', function () {
    var promise = multiArticleLoader();
    promise.then(function(arts){
      articles = arts;
    });
    mockBackend.flush();
    expect(articles.length).toBe(2);
  });
});
