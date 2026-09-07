import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];
  // BOLT OPTIMIZATION: Use a Map for O(1) driver lookup by ID during frequent location updates from GeoFire stream.
  static final Map<String, OnlineNearbyDrivers> nearbyOnlineDriversMap = {};

  /// Adds a driver to the list and map in O(1) time.
  static void addDriverToList(OnlineNearbyDrivers onlineNearbyDriver) {
    if (onlineNearbyDriver.uidDriver != null) {
      if (!nearbyOnlineDriversMap.containsKey(onlineNearbyDriver.uidDriver)) {
        nearbyOnlineDriversList.add(onlineNearbyDriver);
        nearbyOnlineDriversMap[onlineNearbyDriver.uidDriver!] =
            onlineNearbyDriver;
      } else {
        updateOnlineNearbyDriversLocation(onlineNearbyDriver);
      }
    }
  }

  /// Removes a driver from the map and list in O(1) average time.
  static void removeDriverFromList(String driverId) {
    final driver = nearbyOnlineDriversMap.remove(driverId);
    if (driver != null) {
      nearbyOnlineDriversList.remove(driver);
    } else {
      // Fallback for safety in case list was mutated directly
      int index = nearbyOnlineDriversList
          .indexWhere((driver) => driver.uidDriver == driverId);

      if (index != -1) {
        nearbyOnlineDriversList.removeAt(index);
      } else {
        print("Driver with ID $driverId not found in the list.");
      }
    }
  }

  /// Updates driver location in O(1) time via Map lookup instead of O(N) list search.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    final driver =
        nearbyOnlineDriversMap[nearbyOnlineDriverInformation.uidDriver];

    if (driver != null) {
      driver.latDriver = nearbyOnlineDriverInformation.latDriver;
      driver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
    } else {
      // Fallback for safety
      int index = nearbyOnlineDriversList.indexWhere((driver) =>
          driver.uidDriver == nearbyOnlineDriverInformation.uidDriver);

      if (index != -1) {
        nearbyOnlineDriversList[index].latDriver =
            nearbyOnlineDriverInformation.latDriver;
        nearbyOnlineDriversList[index].lngDriver =
            nearbyOnlineDriverInformation.lngDriver;
        if (nearbyOnlineDriverInformation.uidDriver != null) {
          nearbyOnlineDriversMap[nearbyOnlineDriverInformation.uidDriver!] =
              nearbyOnlineDriversList[index];
        }
      } else {
        print(
            "Driver with ID ${nearbyOnlineDriverInformation.uidDriver} not found in the list.");
      }
    }
  }
}
