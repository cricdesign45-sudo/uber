import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  // Underlying list containing active nearby drivers
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  // Index map mapping driver UID -> driver object for O(1) lookups
  static final Map<String, OnlineNearbyDrivers> _driverMap = {};

  /// Adds a driver to the list and updates index map in O(1) time.
  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver != null) {
      if (_driverMap.containsKey(driver.uidDriver)) {
        // Update existing driver in place
        updateOnlineNearbyDriversLocation(driver);
      } else {
        _driverMap[driver.uidDriver!] = driver;
        nearbyOnlineDriversList.add(driver);
      }
    }
  }

  /// Removes a driver from the list and index map in O(1) lookup time.
  static void removeDriverFromList(String driverId) {
    final driver = _driverMap.remove(driverId);
    if (driver != null) {
      nearbyOnlineDriversList.remove(driver);
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  /// Updates driver location in O(1) lookup time.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    String? driverId = nearbyOnlineDriverInformation.uidDriver;
    if (driverId != null) {
      final driver = _driverMap[driverId];
      if (driver != null) {
        driver.latDriver = nearbyOnlineDriverInformation.latDriver;
        driver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
      } else {
        print("Driver with ID $driverId not found in the list.");
      }
    }
  }

  /// Clears all tracked drivers and index map.
  static void clearDriversList() {
    _driverMap.clear();
    nearbyOnlineDriversList.clear();
  }
}
