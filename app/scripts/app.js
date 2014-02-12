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
          articles: function (MultiArticleLoader) {
            return MultiArticleLoader();
          }
        }
      })
      .when('/article/:articleId', {
        templateUrl: 'views/article.html',
        controller: 'ArticleViewCtrl',
        resolve: {
          article: function (ArticleLoader, $route) {
            return ArticleLoader($route.current.params.articleId);
          }
        }
      })
      .when('/article/:articleId/edit', {
        templateUrl: 'views/edit_article.html',
        controller: 'EditArticleCtrl',
        resolve: {
          article: function (ArticleLoader, $route) {
            return ArticleLoader($route.current.params.articleId);
          }
        }
      })
      .otherwise({
        redirectTo: '/'
      });
  });
