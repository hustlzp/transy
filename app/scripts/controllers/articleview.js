'use strict';

angular.module('transyApp')
  .controller('ArticleViewCtrl', function ($scope, $rootScope, $location, article, $window) {
    $rootScope.pageId = 'page-article';
    $rootScope.pageTitle = article.cnTitle;

    $scope.article = article;

    $scope.showEn = true;
    $scope.showCn = true;

    $scope.edit = function () {
      $location.path('/article/' + article._id + '/edit');
    };

    // 删除文章
    $scope.remove = function () {
      if ($window.confirm('确认删除此文？')) {
        $scope.article.$remove(function () {
          $location.path('/');
        });
      }
    };

    // 切换显示模式
    $scope.showMode = function (mode) {
      if (mode === 'ec') {
        $scope.showEn = true;
        $scope.showCn = true;
      } else if (mode === 'en') {
        $scope.showEn = true;
        $scope.showCn = false;
      } else if (mode === 'cn') {
        $scope.showEn = false;
        $scope.showCn = true;
      }
    };
  });
