import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  // Optimization: Map to allow O(1) hash table lookup by driver ID instead of O(N) linear scans
  static Map<String, OnlineNearbyDrivers> nearbyOnlineDriversMap = {};

  static void addDriver(OnlineNearbyDrivers driver) {
    if (driver.uidDriver != null) {
      if (nearbyOnlineDriversMap.containsKey(driver.uidDriver)) {
        // Driver already exists: update existing instance to keep List and Map in sync
        var existingDriver = nearbyOnlineDriversMap[driver.uidDriver!]!;
        existingDriver.latDriver = driver.latDriver;
        existingDriver.lngDriver = driver.lngDriver;
      } else {
        nearbyOnlineDriversList.add(driver);
        nearbyOnlineDriversMap[driver.uidDriver!] = driver;
      }
    }
  }

  static void removeDriverFromList(String driverId) {
    OnlineNearbyDrivers? driverToRemove = nearbyOnlineDriversMap.remove(driverId);

    if (driverToRemove != null) {
      nearbyOnlineDriversList.remove(driverToRemove);
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    String? driverId = nearbyOnlineDriverInformation.uidDriver;
    if (driverId != null && nearbyOnlineDriversMap.containsKey(driverId)) {
      OnlineNearbyDrivers driver = nearbyOnlineDriversMap[driverId]!;
      driver.latDriver = nearbyOnlineDriverInformation.latDriver;
      driver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
    } else {
      print(
          "Driver with ID $driverId not found in the list.");
    }
  }
}
