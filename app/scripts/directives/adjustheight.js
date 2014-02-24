'use strict';

angular.module('transyApp')
  .directive('adjustHeight', function ($timeout) {
    return {
      restrict: 'A',
      scope: { val: '=watchTarget' },
      link: function (scope, element, attrs) {
        scope.$watch('val', function () {
          // 这里需要使用timeout，这样的话就可以将function重新设置到event queue的最末端执行
          // 这样就可以保证执行的时候HTML已经渲染完毕
          $timeout(function () {
            // 获取en、cn中的较大高度
            var enHeight = element.find('.en').first().innerHeight();
            var cnHeight = element.find('.cn').first().innerHeight();
            var height = (enHeight > cnHeight) ? enHeight : cnHeight;

            // 设置ec-divider的高度
            element.find('.ec-divider').height(height + 15);
          }, 0);
        }, true);
      }
    };
  });
