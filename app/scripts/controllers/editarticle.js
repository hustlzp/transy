'use strict';

angular.module('transyApp')
  .controller('EditArticleCtrl', function ($scope, $rootScope, $location, article) {
    $rootScope.pageId = 'page-edit-article';
    $rootScope.pageTitle = '编辑文章';
    $scope.article = article;
    $scope.save = function () {
      $scope.article.$save();
    };
  });
