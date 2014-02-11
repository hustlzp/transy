'use strict';

angular.module('transyApp')
  .factory('ArticleLoader', function ($routeParams, Article, $q) {
    return function (articleId) {
      var delay = $q.defer();
      Article.get({id: articleId}, function (article) {
        delay.resolve(article);
      }, function () {
        delay.reject('Unable to fetch article');
      });
      return delay.promise;
    };
  });