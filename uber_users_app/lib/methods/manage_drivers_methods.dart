import 'package:uber_users_app/models/online_nearby_drivers.dart';

/// Manages active nearby online drivers with O(1) Map indexing for performance
/// optimization during high-frequency Geofire location updates and removals.
class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  // O(1) lookup map mapping driver UID to driver object
  static final Map<String, OnlineNearbyDrivers> _driverMap = {};

  /// Clears all tracked drivers.
  static void clearDrivers() {
    nearbyOnlineDriversList.clear();
    _driverMap.clear();
  }

  /// Adds a driver to the tracking list and map index in O(1) time.
  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver == null) return;

    // If driver already exists in map, update list reference
    if (_driverMap.containsKey(driver.uidDriver)) {
      _driverMap[driver.uidDriver!]!.latDriver = driver.latDriver;
      _driverMap[driver.uidDriver!]!.lngDriver = driver.lngDriver;
    } else {
      _driverMap[driver.uidDriver!] = driver;
      nearbyOnlineDriversList.add(driver);
    }
  }

  /// Removes a driver from the tracking list and map index in O(1) time lookup.
  static void removeDriverFromList(String driverId) {
    OnlineNearbyDrivers? driver = _driverMap.remove(driverId);

    if (driver != null) {
      nearbyOnlineDriversList.remove(driver);
    } else {
      // Fallback for cases where driver list was manipulated directly
      int index = nearbyOnlineDriversList
          .indexWhere((d) => d.uidDriver == driverId);
      if (index != -1) {
        nearbyOnlineDriversList.removeAt(index);
      } else {
        print("Driver with ID $driverId not found in the list.");
      }
    }
  }

  /// Updates driver location in O(1) time lookup.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    String? driverId = nearbyOnlineDriverInformation.uidDriver;
    if (driverId == null) return;

    OnlineNearbyDrivers? existingDriver = _driverMap[driverId];

    if (existingDriver != null) {
      existingDriver.latDriver = nearbyOnlineDriverInformation.latDriver;
      existingDriver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
    } else {
      // Fallback for cases where driver was added without map indexing
      int index = nearbyOnlineDriversList
          .indexWhere((driver) => driver.uidDriver == driverId);

      if (index != -1) {
        nearbyOnlineDriversList[index].latDriver =
            nearbyOnlineDriverInformation.latDriver;
        nearbyOnlineDriversList[index].lngDriver =
            nearbyOnlineDriverInformation.lngDriver;
        _driverMap[driverId] = nearbyOnlineDriversList[index];
      } else {
        print(
            "Driver with ID $driverId not found in the list.");
      }
    }
  }
}
