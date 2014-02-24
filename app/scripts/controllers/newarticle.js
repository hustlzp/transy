'use strict';

angular.module('transyApp')
  .controller('NewArticleCtrl', function ($scope, $location, $rootScope, Article) {
    $rootScope.pageId = 'page-new-article';
    $rootScope.pageTitle = '新文章';

    $scope.article = new Article();

    $scope.submit = function () {
      $scope.article.$save(function (article) {
        $location.path('/article/' + article._id);
      });
    };
  });
