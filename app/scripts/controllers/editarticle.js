'use strict';

angular.module('transyApp')
  .controller('EditArticleCtrl', function ($scope, $rootScope, article) {
    $rootScope.pageId = 'page-edit-article';
    $rootScope.pageTitle = '编辑文章';
    $scope.article = article;
  });
