'use strict';

angular.module('transyApp')
  .service('contextmenuService', function () {
    var index = 0;  // 私有变量，列表item索引

    this.setIndex = function (value) {
      index = value;
    };

    this.getIndex = function () {
      return index;
    };
  })
  .directive('contextmenu', function ($window, contextmenuService) {
    return {
      restrict: 'A',
      link: function (scope, element, attrs) {
        var menu = angular.element('.context-menu');

        var open = function (event, element) {
          element.css('top', event.clientY + 'px');
          element.css('left', event.clientX + 'px');
          element.css('display', 'block');
        };

        var close = function (element) {
          element.css('display', 'none');
        };

        // 在element上点击右键时，显示菜单
        // 并将当前点击的index存储到service中
        element.bind('contextmenu', function (event) {
          var index = element.data('index');

          scope.$apply(function () {
            event.preventDefault(); // 阻止浏览器默认的右键行为
            open(event, menu);
            contextmenuService.setIndex(index);
          });
        });

        // 点击页面其他地方，则隐藏菜单
        angular.element($window).bind('click', function (event) {
          scope.$apply(function () {
            event.preventDefault();
            close(menu);
          });
        });
      }
    };
  });
