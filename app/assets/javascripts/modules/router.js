(function(_, angular) {

  function Router(settings) {
    _.extend(this, settings);

    _.bindAll(this, '_setRouteConfig', '_setRoutesConfig');
  }

  function RouterProvider() {
    _.bindAll(this, 'instance');
    this.$get = [this.instance];
  };

  var module = angular.module('router', []),
      fn = Router.prototype,
      fnrp = RouterProvider.prototype;

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

  module.provider('router', RouterProvider);
}(window._, window.angular));
