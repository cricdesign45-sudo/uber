import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  // Optimization: Maintain an internal Map for O(1) driver lookups and removals
  // during frequent GeoFire location updates (onKeyEntered, onKeyMoved, onKeyExited),
  // while keeping nearbyOnlineDriversList synchronized for consumer views.
  static final Map<String, OnlineNearbyDrivers> _driversMap = {};
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver != null) {
      if (_driversMap.containsKey(driver.uidDriver)) {
        // Update existing driver in place
        _driversMap[driver.uidDriver!]!.latDriver = driver.latDriver;
        _driversMap[driver.uidDriver!]!.lngDriver = driver.lngDriver;
      } else {
        _driversMap[driver.uidDriver!] = driver;
        nearbyOnlineDriversList.add(driver);
      }
    }
  }

  static void removeDriverFromList(String driverId) {
    // O(1) map lookup instead of O(N) linear search
    final removed = _driversMap.remove(driverId);
    if (removed != null) {
      // Remove from list
      nearbyOnlineDriversList.remove(removed);
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    final driverId = nearbyOnlineDriverInformation.uidDriver;
    // O(1) map lookup instead of O(N) linear indexWhere
    final existingDriver = driverId != null ? _driversMap[driverId] : null;

    if (existingDriver != null) {
      existingDriver.latDriver = nearbyOnlineDriverInformation.latDriver;
      existingDriver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
    } else {
      // If driver was not previously in the map, register it
      if (driverId != null) {
        _driversMap[driverId] = nearbyOnlineDriverInformation;
        nearbyOnlineDriversList.add(nearbyOnlineDriverInformation);
      }
      print(
          "Driver with ID ${nearbyOnlineDriverInformation.uidDriver} not found in the list.");
    }
  }

  /// Clears all stored drivers (useful for session resets and testing).
  static void clear() {
    _driversMap.clear();
    nearbyOnlineDriversList.clear();
  }
}
