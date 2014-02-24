'use strict';

describe('Controller: NewArticleCtrl', function () {

  // load the controller's module
  beforeEach(module('transyApp'));

  var newArticleCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    newArticleCtrl = $controller('NewArticleCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
