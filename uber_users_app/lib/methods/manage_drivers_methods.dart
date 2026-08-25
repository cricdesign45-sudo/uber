import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  // BOLT OPTIMIZATION: Index Map for driver lookup/update/removal by UID
  static final Map<String, OnlineNearbyDrivers> _nearbyOnlineDriversMap = {};

  /// Clears both the list and the lookup index map.
  static void clearDriversList() {
    nearbyOnlineDriversList.clear();
    _nearbyOnlineDriversMap.clear();
  }

  /// Adds a driver to the nearby list and index map.
  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver != null) {
      if (!_nearbyOnlineDriversMap.containsKey(driver.uidDriver)) {
        nearbyOnlineDriversList.add(driver);
        _nearbyOnlineDriversMap[driver.uidDriver!] = driver;
      } else {
        // Driver exists, update location/data in place
        updateOnlineNearbyDriversLocation(driver);
      }
    }
  }

  /// Removes a driver by ID in O(N) list removal, maintaining map index synchronization.
  static void removeDriverFromList(String driverId) {
    final existingDriver = _nearbyOnlineDriversMap.remove(driverId);
    if (existingDriver != null) {
      nearbyOnlineDriversList.remove(existingDriver);
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  /// Updates driver location in O(1) time using map lookup.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyDriverInformation) {
    final driver = _nearbyOnlineDriversMap[nearbyDriverInformation.uidDriver];
    if (driver != null) {
      driver.latDriver = nearbyDriverInformation.latDriver;
      driver.lngDriver = nearbyDriverInformation.lngDriver;
    } else {
      print(
          "Driver with ID ${nearbyDriverInformation.uidDriver} not found in the list.");
    }
  }
}
