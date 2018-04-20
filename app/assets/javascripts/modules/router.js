(function(_, angular) {

  function Router(settings) {
    _.extend(this, settings);

    _.bindAll(this, '_setRouteConfig', '_setRoutesConfig');
  }

  var app = angular.module('aribeth'),
      fn = Router.prototype;

  fn.bindRoutes = function () {
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

  Router.Builder = function($routeProvider, routerProvider) {
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

  function RouterProvider() {
    _.bindAll(this, 'instance');
    this.$get = [this.instance];
  };

  var fnrp = RouterProvider.prototype;

  fnrp.instance = function() {
    return this.router || this._build();
  };

  fnrp._build = function routerFactory() {
    return this.router = new Router({
      provider: this.provider,
      defaultConfig: this.defaultConfig,
      configs: this.configs,
      customRoutes: this.customRoutes
    });
  };

  app.provider('router', RouterProvider);
  app.config(['$routeProvider', 'routerProvider', Router.Builder]);
}(window._, window.angular));
