import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];
  // Performance optimization: Maintain a map for O(1) lookup, update, and removal
  static Map<String, OnlineNearbyDrivers> nearbyOnlineDriversMap = {};

  /// Clears both list and map to maintain synchronized state.
  static void clearDrivers() {
    nearbyOnlineDriversList.clear();
    nearbyOnlineDriversMap.clear();
  }

  /// Adds driver to both the list and lookup map.
  static void addDriver(OnlineNearbyDrivers driver) {
    if (driver.uidDriver == null) return;
    if (nearbyOnlineDriversMap.containsKey(driver.uidDriver)) {
      updateOnlineNearbyDriversLocation(driver);
    } else {
      nearbyOnlineDriversList.add(driver);
      nearbyOnlineDriversMap[driver.uidDriver!] = driver;
    }
  }

  /// Removes driver from both list and map in O(1) average time via map reference lookup.
  static void removeDriverFromList(String driverId) {
    OnlineNearbyDrivers? driverToRemove = nearbyOnlineDriversMap.remove(driverId);

    if (driverToRemove != null) {
      nearbyOnlineDriversList.remove(driverToRemove);
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  /// Updates online driver location in O(1) time using the map lookup.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    if (nearbyOnlineDriverInformation.uidDriver == null) return;

    OnlineNearbyDrivers? existingDriver =
        nearbyOnlineDriversMap[nearbyOnlineDriverInformation.uidDriver];

    if (existingDriver != null) {
      existingDriver.latDriver = nearbyOnlineDriverInformation.latDriver;
      existingDriver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
    } else {
      print(
          "Driver with ID ${nearbyOnlineDriverInformation.uidDriver} not found in the list.");
    }
  }
}
