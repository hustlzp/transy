'use strict';

describe('Service: Article', function () {

  // load the service's module
  beforeEach(module('transyApp'));

  // instantiate service
  var article, Article, mockBackend;
  beforeEach(inject(function (_Article_, _$httpBackend_) {
    var url = 'http://localhost:3000/article/1';
    Article = _Article_;
    mockBackend = _$httpBackend_;
    mockBackend.expectGET(url).respond({'cnTitle': 'title'});
  }));

  it('should get the correct article', function () {
    article = Article.get({id: 1});
    mockBackend.flush();
    expect(article.cnTitle).toEqual('title');
  });

});
