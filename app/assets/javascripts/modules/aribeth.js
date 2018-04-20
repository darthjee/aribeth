(function(angular) {
  var module = angular.module('aribeth', [
    'ngRoute', 'global', 'router'
  ]);

  module.config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.headers.patch = {
      'Content-Type': 'application/json;charset=utf-8'
    };
  }]);
}(window.angular));

