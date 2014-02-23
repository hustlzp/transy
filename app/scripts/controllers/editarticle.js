'use strict';

angular.module('transyApp')
  .controller('EditArticleCtrl', function ($scope, $rootScope, $location, article, contextmenuService) {
    $rootScope.pageId = 'page-edit-article';
    $rootScope.pageTitle = '编辑文章';

    $scope.article = article;
    $scope.save = function () {
      $scope.article.$save();
    };
    $scope.remove = function(){
      var index = contextmenuService.getIndex();
      $scope.article.paraList.splice(index, 1);
    };
  });
