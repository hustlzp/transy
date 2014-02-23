'use strict';

angular.module('transyApp')
  .controller('EditArticleCtrl', function ($scope, $rootScope, $location, article, contextmenuService) {
    $rootScope.pageId = 'page-edit-article';
    $rootScope.pageTitle = '编辑文章';

    $scope.article = article;

    // 保存文章
    $scope.save = function () {
      $scope.article.$save();
    };

    // 移除段落
    $scope.remove = function () {
      var index = contextmenuService.getIndex();
      $scope.article.paraList.splice(index, 1);
    };

    // 在上方增加段落
    $scope.addAbove = function () {
      var index = contextmenuService.getIndex();
      $scope.article.paraList.splice(index, 0, {
        en: '',
        cn: '',
        type: 'text',
        status: false
      });
    };

    // 在下方增加段落
    $scope.addBelow = function () {
      var index = contextmenuService.getIndex();
      $scope.article.paraList.splice(index+1, 0, {
        en: '',
        cn: '',
        type: 'text',
        status: false
      });
    };
  });
