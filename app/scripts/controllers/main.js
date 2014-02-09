'use strict';

angular.module('transyApp')
  .controller('MainCtrl', function ($scope, articles) {
    $scope.articles = articles;
  });
