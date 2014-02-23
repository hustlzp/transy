'use strict';

angular.module('transyApp')
  .directive('adjustHeight', function ($timeout) {
    return {
      restrict: 'A',
      scope: { val: '=watchTarget' },
      link: function (scope, element, attrs) {
        scope.$watch('val', function () {
          $timeout(function () {
            // 获取en、cn中的较大高度
            var enHeight = element.find('.en').first().height();
            var cnHeight = element.find('.cn').first().height();
            var height = (enHeight > cnHeight) ? enHeight : cnHeight;

            // 设置ec-divider的高度
            element.find('.ec-divider').height(height + 15);
          });
        }, true);
      }
    };
  });
