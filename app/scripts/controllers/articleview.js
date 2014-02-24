'use strict';

angular.module('transyApp')
  .controller('ArticleViewCtrl', function ($scope, $rootScope, $location, article) {
    $rootScope.pageId = 'page-article';
    $rootScope.pageTitle = article.cnTitle;
    $scope.article = article;
    $scope.edit = function () {
      $location.path('/article/' + article._id + '/edit');
    };
  });
