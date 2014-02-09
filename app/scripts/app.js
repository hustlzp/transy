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
      .otherwise({
        redirectTo: '/'
      });
  });
