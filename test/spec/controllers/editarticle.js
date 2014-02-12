'use strict';

describe('Controller: EditArticleCtrl', function () {

  // load the controller's module
  beforeEach(module('transyApp'));

  var EditArticleCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    EditArticleCtrl = $controller('EditArticleCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
