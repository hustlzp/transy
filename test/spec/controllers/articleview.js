'use strict';

describe('Controller: ArticleViewCtrl', function () {

  // load the controller's module
  beforeEach(module('transyApp'));

  var ArticleViewCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    ArticleViewCtrl = $controller('ArticleViewCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
