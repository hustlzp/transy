'use strict';

angular.module('transyApp')
  .factory('Article', ['$resource', function ($resource) {
    return $resource('http://localhost:3000/articles/:id', {id: @id});
  }]);
