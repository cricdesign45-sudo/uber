import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  // Performance Optimization: Cache driver objects by ID in a HashMap for O(1) lookups
  // during high-frequency location updates (Geofire onKeyMoved events).
  static final Map<String, OnlineNearbyDrivers> _nearbyOnlineDriversMap = {};

  /// Adds a nearby online driver to both the list and the lookup map.
  static void addDriver(OnlineNearbyDrivers driver) {
    if (driver.uidDriver != null) {
      int existingIndex = nearbyOnlineDriversList
          .indexWhere((d) => d.uidDriver == driver.uidDriver);
      if (existingIndex != -1) {
        nearbyOnlineDriversList[existingIndex] = driver;
      } else {
        nearbyOnlineDriversList.add(driver);
      }
      _nearbyOnlineDriversMap[driver.uidDriver!] = driver;
    }
  }

  /// Clears both the driver list and the lookup map.
  static void clearAllDrivers() {
    nearbyOnlineDriversList.clear();
    _nearbyOnlineDriversMap.clear();
  }

  /// Removes a driver from both the lookup map and the list in O(1) amortized time.
  static void removeDriverFromList(String driverId) {
    OnlineNearbyDrivers? driver = _nearbyOnlineDriversMap.remove(driverId);
    if (driver != null) {
      nearbyOnlineDriversList.remove(driver);
    } else {
      // Fallback if driver was added directly to nearbyOnlineDriversList
      int index = nearbyOnlineDriversList
          .indexWhere((driver) => driver.uidDriver == driverId);

      if (index != -1) {
        nearbyOnlineDriversList.removeAt(index);
      } else {
        print("Driver with ID $driverId not found in the list.");
      }
    }
  }

  /// Updates a driver's location in O(1) time using map lookup instead of O(N) linear search.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    String? driverId = nearbyOnlineDriverInformation.uidDriver;
    if (driverId == null) return;

    OnlineNearbyDrivers? driver = _nearbyOnlineDriversMap[driverId];

    if (driver != null) {
      // O(1) fast path: update location directly on cached object reference
      driver.latDriver = nearbyOnlineDriverInformation.latDriver;
      driver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
    } else {
      // Fallback path if driver was added directly to nearbyOnlineDriversList
      int index = nearbyOnlineDriversList
          .indexWhere((driver) => driver.uidDriver == driverId);

      if (index != -1) {
        nearbyOnlineDriversList[index].latDriver =
            nearbyOnlineDriverInformation.latDriver;
        nearbyOnlineDriversList[index].lngDriver =
            nearbyOnlineDriverInformation.lngDriver;
        _nearbyOnlineDriversMap[driverId] = nearbyOnlineDriversList[index];
      } else {
        print("Driver with ID $driverId not found in the list.");
      }
    }
  }
}
