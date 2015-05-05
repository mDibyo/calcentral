(function(angular) {
  'use strict'

  /**
   * Dining Locations Controller
   */
  angular.module('calcentral.controllers').controller('DiningLocationsController', function(apiService, diningMenusFactory, $scope) {
    var bindScopes = function(diningMenus) {
      $scope.diningMenus = diningMenus;
    };

    var getDiningMenus = function(options) {
      diningMenusFactory.getMenus(options).then(function(data) {
        apiService.updatedFeeds.feedLoaded(data.feed);
        bindScopes(data.dining_menus);
        angular.extend($scope, data);
      })
    };

    $scope.$on('calcentral.api.updatedFeeds.updateServices', function(event, services) {
      //if (services && services['DiningMenus::Merged']) {
      if (services) {
        getDiningMenus({
          refreshCache: true
        });
      }
    });

    getDiningMenus();
  });
})(window.angular);
