import 'package:uber_users_app/models/online_nearby_drivers.dart';

/// ManageDriversMethods handles nearby online drivers tracking.
/// Optimized using a Map for O(1) lookups and removals, avoiding
/// list reconstruction overhead during in-place location updates.
class ManageDriversMethods {
  static final Map<String, OnlineNearbyDrivers> nearbyOnlineDriversMap = {};
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver != null) {
      nearbyOnlineDriversMap[driver.uidDriver!] = driver;
      _syncList();
    }
  }

  static void removeDriverFromList(String driverId) {
    // O(1) removal using Map key lookup
    if (nearbyOnlineDriversMap.containsKey(driverId)) {
      nearbyOnlineDriversMap.remove(driverId);
      _syncList();
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    // O(1) in-place update without reconstructing list to prevent allocation overhead
    String? driverId = nearbyOnlineDriverInformation.uidDriver;
    if (driverId != null && nearbyOnlineDriversMap.containsKey(driverId)) {
      var existingDriver = nearbyOnlineDriversMap[driverId]!;
      existingDriver.latDriver = nearbyOnlineDriverInformation.latDriver;
      existingDriver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
    } else {
      print(
          "Driver with ID ${nearbyOnlineDriverInformation.uidDriver} not found in the list.");
    }
  }

  static void _syncList() {
    nearbyOnlineDriversList = nearbyOnlineDriversMap.values.toList();
  }
}
