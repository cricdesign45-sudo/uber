import 'package:uber_users_app/models/online_nearby_drivers.dart';

/// Manages the state and location updates of online nearby drivers.
/// Uses an internal Map for O(1) lookups by driver ID to optimize
/// additions, removals, and location updates for frequent GeoFire callbacks.
class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];
  static final Map<String, OnlineNearbyDrivers> _nearbyOnlineDriversMap = {};

  /// Clears all tracked drivers.
  static void clear() {
    nearbyOnlineDriversList.clear();
    _nearbyOnlineDriversMap.clear();
  }

  /// Adds a driver to the tracking collection in O(1) time complexity.
  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver == null) return;

    if (_nearbyOnlineDriversMap.containsKey(driver.uidDriver)) {
      // If already present, update location directly
      updateOnlineNearbyDriversLocation(driver);
    } else {
      _nearbyOnlineDriversMap[driver.uidDriver!] = driver;
      nearbyOnlineDriversList.add(driver);
    }
  }

  /// Removes a driver from the tracking collection in O(1) map lookup time.
  static void removeDriverFromList(String driverId) {
    final removedDriver = _nearbyOnlineDriversMap.remove(driverId);
    if (removedDriver != null) {
      nearbyOnlineDriversList.remove(removedDriver);
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  /// Updates driver location in O(1) map lookup time.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    if (nearbyOnlineDriverInformation.uidDriver == null) return;

    final existingDriver =
        _nearbyOnlineDriversMap[nearbyOnlineDriverInformation.uidDriver];

    if (existingDriver != null) {
      existingDriver.latDriver = nearbyOnlineDriverInformation.latDriver;
      existingDriver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
    } else {
      print(
          "Driver with ID ${nearbyOnlineDriverInformation.uidDriver} not found in the list.");
    }
  }
}
