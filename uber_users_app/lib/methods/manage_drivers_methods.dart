import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  // Public list maintained for backwards compatibility with UI iteration.
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  // Performance Optimization: Map index for O(1) driver lookups and updates.
  // Geofire fires high-frequency stream events (onKeyMoved, onKeyExited) for every
  // moving nearby driver. Looking up by driverId using indexWhere resulted in O(N)
  // linear scan overhead per event. Maintaining an internal Map index reduces
  // lookups from O(N) to O(1).
  static final Map<String, OnlineNearbyDrivers> _driversMap = {};

  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver != null) {
      if (_driversMap.containsKey(driver.uidDriver)) {
        updateOnlineNearbyDriversLocation(driver);
      } else {
        _driversMap[driver.uidDriver!] = driver;
        nearbyOnlineDriversList.add(driver);
      }
    }
  }

  static void removeDriverFromList(String driverId) {
    // Sync map if list was mutated externally
    _syncMapIfNeeded();

    final driver = _driversMap.remove(driverId);
    if (driver != null) {
      nearbyOnlineDriversList.remove(driver);
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    // Sync map if list was mutated externally
    _syncMapIfNeeded();

    final driverId = nearbyOnlineDriverInformation.uidDriver;
    final driver = driverId != null ? _driversMap[driverId] : null;

    if (driver != null) {
      driver.latDriver = nearbyOnlineDriverInformation.latDriver;
      driver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
    } else {
      print(
          "Driver with ID ${nearbyOnlineDriverInformation.uidDriver} not found in the list.");
    }
  }

  static void clear() {
    nearbyOnlineDriversList.clear();
    _driversMap.clear();
  }

  // Ensures _driversMap reflects nearbyOnlineDriversList if it was directly modified
  static void _syncMapIfNeeded() {
    if (_driversMap.length != nearbyOnlineDriversList.length) {
      _driversMap.clear();
      for (final driver in nearbyOnlineDriversList) {
        if (driver.uidDriver != null) {
          _driversMap[driver.uidDriver!] = driver;
        }
      }
    }
  }
}
