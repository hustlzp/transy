'use strict';

describe('Directive: adjustHeight', function () {

  // load the directive's module
  beforeEach(module('transyApp'));

  var element,
    scope;

  beforeEach(inject(function ($rootScope) {
    scope = $rootScope.$new();
  }));

  it('should make hidden element visible', inject(function ($compile) {
    element = angular.element('<adjust-height></adjust-height>');
    element = $compile(element)(scope);
    expect(element.text()).toBe('this is the adjustHeight directive');
  }));
});
