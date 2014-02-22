'use strict';

describe('Directive: contextmenu', function () {

  // load the directive's module
  beforeEach(module('transyApp'));

  var element,
    scope;

  beforeEach(inject(function ($rootScope) {
    scope = $rootScope.$new();
  }));

  it('should make hidden element visible', inject(function ($compile) {
    element = angular.element('<contextmenu></contextmenu>');
    element = $compile(element)(scope);
    expect(element.text()).toBe('this is the contextmenu directive');
  }));
});
