'use strict';

angular.module('transyApp')
  .controller('ArticleViewCtrl', function ($scope, $rootScope, $location, article) {
    var html = '';

    // Build html for article content
    angular.forEach(article.paraList, function (para) {
      switch (para.type) {
        case 'header':
          html += '<h3 class="en">' + para.en + '</h3>';
          html += '<h3 class="cn">' + para.cn + '</h3>';
          break;
        case 'text':
          html += '<p class="en">' + para.en + '</p>';
          html += '<p class="cn">' + para.cn + '</p>';
          break;
        case 'quote':
          html += '<blockquote class="en">' + para.en + '</blockquote>';
          html += '<blockquote class="cn">' + para.cn + '</blockquote>';
          break;
        case 'image':
          html += '<p><img src="' + para.en + '">' + '"/></p>';
          break;
      }
    });
    $rootScope.pageId = 'page-article';
    $rootScope.pageTitle = article.cnTitle;
    $scope.article = article;
    $scope.html = html;
    $scope.edit = function () {
      $location.path('/article/' + article._id + '/edit');
    };
  });