import 'package:uber_users_app/models/online_nearby_drivers.dart';

/// Helper for managing nearby online drivers using an O(1) Map lookup index
/// alongside the List representation for iterations and location updates.
class ManageDriversMethods {
  static final List<OnlineNearbyDrivers> _nearbyOnlineDriversList = [];
  static final Map<String, OnlineNearbyDrivers> _driverIndexMap = {};

  /// Returns the current list of nearby online drivers.
  static List<OnlineNearbyDrivers> get nearbyOnlineDriversList =>
      _nearbyOnlineDriversList;

  /// Clears all driver entries from both the list and the map index.
  static void clearDriversList() {
    _nearbyOnlineDriversList.clear();
    _driverIndexMap.clear();
  }

  /// Adds a driver to the list and updates the internal O(1) map index.
  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver == null) return;
    if (_driverIndexMap.containsKey(driver.uidDriver)) {
      // If driver already exists, update their location details instead of duplicating
      updateOnlineNearbyDriversLocation(driver);
    } else {
      _driverIndexMap[driver.uidDriver!] = driver;
      _nearbyOnlineDriversList.add(driver);
    }
  }

  /// Removes a driver with [driverId] from the map index and list.
  static void removeDriverFromList(String driverId) {
    final driver = _driverIndexMap.remove(driverId);
    if (driver != null) {
      _nearbyOnlineDriversList.remove(driver);
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  /// Updates the location of an online nearby driver in O(1) lookup time using the map index.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    final driverId = nearbyOnlineDriverInformation.uidDriver;
    final existingDriver = _driverIndexMap[driverId];

    if (existingDriver != null) {
      existingDriver.latDriver = nearbyOnlineDriverInformation.latDriver;
      existingDriver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
    } else {
      print(
          "Driver with ID ${nearbyOnlineDriverInformation.uidDriver} not found in the list.");
    }
  }
}
