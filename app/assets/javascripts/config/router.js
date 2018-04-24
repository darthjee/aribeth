(function(_, angular) {
  var app = angular.module('aribeth');

  function RouterConfigurator($routeProvider, routerProvider) {
    routerProvider.provider = $routeProvider;
    routerProvider.defaultConfig = {
      controller: 'Global.GenericController',
      controllerAs: 'controller'
    };
    routerProvider.configs = [{
      routes: [
        '/races',
        '/races/new',
        '/races/:id',
        '/races/:id/edit'
      ]
    }];
    routerProvider.customRoutes = {
    };
    routerProvider.instance().bindRoutes();
  };
  app.config(['$routeProvider', 'routerProvider', RouterConfigurator]);
}(window._, window.angular));
