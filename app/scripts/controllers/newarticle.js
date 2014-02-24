'use strict';

angular.module('transyApp')
  .controller('NewArticleCtrl', function ($scope, $rootScope) {
    $rootScope.pageId = 'page-new-article';
    $rootScope.pageTitle = '新文章';

    $scope.article = {};
    $scope.content = '';
    $scope.save = function(){
      // 这里需要对content进行分割处理
      $scope.article.paraList = [$scope.content];
      $scope.article.$save(function(article){
        $location.path('/article/' + article._id);
      });
    };
  });
