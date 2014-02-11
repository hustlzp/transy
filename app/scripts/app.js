'use strict';

angular.module('transyApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl',
        resolve: {
          articles: function(MultiArticleLoader){
            return MultiArticleLoader();
          }
        }
      })
      .when('/article/:articleId', {
        templateUrl: 'views/article.html',
        controller: 'ArticleViewCtrl',
        resolve: {
          article: function(ArticleLoader, $route){
            return ArticleLoader($route.current.params.articleId);
          }
        }
      })
      .otherwise({
        redirectTo: '/'
      });
  });
