'use strict';

angular.module('transyApp')
  .factory('MultiArticleLoader', ['$q', 'Article', function ($q, Article) {
    return function () {
      var delay = $q.defer;
      Article.query(function(articles){
        delay.resolve(articles);
      }, function(){
        delay.reject('Unable to load articles');
      });
      return delay.promise;
    }
  }]);
