(function(angular) {
  'use strict';

  /**
   * Dining Menus Factory
   */
  angular.module('cancentral.factories').factory('diningLocationsFactory', function(apiService) {
    var url = '/dummy/json/dining_menus.json';

    var parseMenus = function(xhr) {
      var data = xhr.data;

      if (!data.dining_menus) {
        return;
      }

      return data;
    };

    var getMenus = function(options) {
      return apiService.http.request(options, url).then(parseMenus);
    };

    return {
      getMenus: getMenus
    };
  })
}(window.angular));
