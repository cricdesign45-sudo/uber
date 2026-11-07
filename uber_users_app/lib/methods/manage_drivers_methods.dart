import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  // Backing list kept for backward compatibility with map iteration and views.
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  // Bolt ⚡ Optimization: Map for O(1) driver lookup and deduplication during continuous GeoFire streams.
  // Replacing O(N) linear scans (`indexWhere`) on high-frequency driver movement events.
  // When dozens of nearby drivers stream GPS location updates via GeoFire onKeyMoved,
  // looking up by key in O(1) prevents O(N) traversal on every coordinate broadcast.
  static final Map<String, OnlineNearbyDrivers> nearbyOnlineDriversMap = {};

  /// Adds a driver to both map and list. If already present, updates in O(1) without duplicating.
  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver == null) return;
    final existingDriver = nearbyOnlineDriversMap[driver.uidDriver];
    if (existingDriver != null) {
      existingDriver.latDriver = driver.latDriver;
      existingDriver.lngDriver = driver.lngDriver;
    } else {
      nearbyOnlineDriversMap[driver.uidDriver!] = driver;
      nearbyOnlineDriversList.add(driver);
    }
  }

  /// Removes a driver in O(1) map lookup and synchronized list removal.
  static void removeDriverFromList(String driverId) {
    final driver = nearbyOnlineDriversMap.remove(driverId);
    if (driver != null) {
      nearbyOnlineDriversList.remove(driver);
    } else {
      // Fallback check in case driver was inserted directly into list
      int index = nearbyOnlineDriversList
          .indexWhere((d) => d.uidDriver == driverId);
      if (index != -1) {
        nearbyOnlineDriversList.removeAt(index);
      } else {
        print("Driver with ID $driverId not found in the list.");
      }
    }
  }

  /// Updates driver coordinates in O(1) using the hash map instead of linear O(N) search.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    final driverId = nearbyOnlineDriverInformation.uidDriver;
    if (driverId == null) return;

    final driver = nearbyOnlineDriversMap[driverId];
    if (driver != null) {
      driver.latDriver = nearbyOnlineDriverInformation.latDriver;
      driver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
    } else {
      // Fallback lookup and cache into map if not present
      int index = nearbyOnlineDriversList
          .indexWhere((d) => d.uidDriver == driverId);
      if (index != -1) {
        nearbyOnlineDriversList[index].latDriver =
            nearbyOnlineDriverInformation.latDriver;
        nearbyOnlineDriversList[index].lngDriver =
            nearbyOnlineDriverInformation.lngDriver;
        nearbyOnlineDriversMap[driverId] = nearbyOnlineDriversList[index];
      } else {
        print("Driver with ID $driverId not found in the list.");
      }
    }
  }

  /// Clears both map and list.
  static void clearDrivers() {
    nearbyOnlineDriversMap.clear();
    nearbyOnlineDriversList.clear();
  }
}
