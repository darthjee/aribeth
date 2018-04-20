(function(_, angular) {
  function Router($routeProvider) {
    this.provider = $routeProvider;

    _.bindAll(this, '_setRouteConfig', '_setRoutesConfig');
  }

  var app = angular.module('aribeth'),
      fn = Router.prototype;

  fn.defaultConfig = {
    controller: 'Global.GenericController',
    controllerAs: 'controller'
  };

  fn.configs = [{
    routes: [
      '/races',
      '/races/new',
      '/races/:id',
      '/races/:id/edit'
    ]
  }];

  fn.customRoutes = {
  };

  fn._bindRoutes = function () {
    _.each(this.configs, this._setRoutesConfig);
    _.each(this.customRoutes, this._setRouteConfig);
  };

  fn._setRoutesConfig = function(settings) {
    var c = this;
    _.each(settings.routes, function(route) {
      c._setRouteConfig(settings.config, route);
    });
  };

  fn._setRouteConfig = function(config, route) {
    config = _.extend({}, this.defaultConfig, {
      templateUrl: this._buildTemplateFor(route)
    }, config);

    this.provider.when(route, config);
  };

  fn._buildTemplateFor = function(route) {
    return function(params) {
      if (params !== undefined) {
        for (key in params) {
          if (params.hasOwnProperty(key)) {
            value = params[key];
            regexp = new RegExp(':' + key + '\\b');
            route = route.replace(regexp, value);
          }
        }
      }
      return route + '?ajax=true';
    }
  }

  Router.Builder = function($routeProvider) {
    new Router($routeProvider)._bindRoutes();
  };

  app.config(['$routeProvider', Router.Builder]);
}(window._, window.angular));
