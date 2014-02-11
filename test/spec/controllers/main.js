'use strict';

describe('Controller: MainCtrl', function () {

  // load the controller's module
  beforeEach(module('transyApp'));

  var MainCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    MainCtrl = $controller('MainCtrl', {
      $scope: scope,
      articles: [1, 2, 3]
    });
  }));

  it('should attach a list of articles to the scope', function () {
    expect(scope.articles).toEqual([1, 2, 3]);
  });
});
