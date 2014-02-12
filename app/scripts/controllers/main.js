'use strict';

angular.module('transyApp')
  .controller('MainCtrl', function ($scope, $rootScope, articles) {
    $rootScope.pageId = 'page-index';
    $rootScope.pageTitle = 'Transy翻译助手';
    $scope.articles = articles;
  });
