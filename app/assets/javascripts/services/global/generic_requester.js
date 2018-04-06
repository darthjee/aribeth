(function(_, angular) {
  function GenericRequesterServiceFactory($http) {
    return new GenericRequesterServiceBuilder($http);
  }

  function GenericRequesterServiceBuilder($http) {
    this.http = $http;
  }

  GenericRequesterServiceBuilder.prototype.build = function($location) {
    var path = $location.$$path + '.json';
    var savePath = $location.$$path.replace(/\/(new|edit)$/, '') + '.json';
    return new GenericRequesterService(path, savePath, this.http);
  };

  function GenericRequesterService(path, savePath, $http) {
    this.path = path;
    this.savePath = savePath;
    this.http = $http;
    _.bind(this.request, this);
  }

  var fn = GenericRequesterService.prototype,
      module = angular.module('global/generic_requester', []);

  fn.request = function(callback) {
    return this.http.get(this.path);
  };

  fn.saveRequest = function(data) {
    if (this.path.match(/new.json$/)) {
      return this.http.post(this.savePath, data);
    } else {
      return this.http.patch(this.savePath, data);
    }
  };

  fn.deleteRequest = function(id) {
    return this.http.delete(this.path.replace(/(\.json)?$/, '/' + id + '.json'));
  };

  Global.GenericRequesterService = GenericRequesterService;

  module.service('generic_requester', [
    '$http',
    GenericRequesterServiceFactory
  ]);
})(window._, window.angular);

