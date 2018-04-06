(function(_, angular, Global) {
  var app = angular.module('global/controller', [
    'global/notifier'
  ]);

  function Controller(notifier) {
    this.notifier = notifier;
  }

  app.controller('Global.Controller', [
    'notifier', Controller
  ]);

  Global.Controller = Controller;
}(window._, window.angular, window.Global));
