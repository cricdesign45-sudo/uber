import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  // BOLT OPTIMIZATION:
  // Maintain a hash map of driver UID -> index in `nearbyOnlineDriversList`.
  // Geofire streams location updates and exits frequently (e.g. hundreds/thousands of events).
  // Replacing linear scans (indexWhere O(N)) with O(1) hash map lookups eliminates
  // redundant iterations over the nearby drivers list on every location tick.
  static final Map<String, int> _driverIndexMap = <String, int>{};

  /// Synchronizes or rebuilds the index map when out of sync.
  static void _rebuildIndexMapIfNeeded() {
    if (_driverIndexMap.length != nearbyOnlineDriversList.length) {
      _driverIndexMap.clear();
      for (int i = 0; i < nearbyOnlineDriversList.length; i++) {
        final String? uid = nearbyOnlineDriversList[i].uidDriver;
        if (uid != null) {
          _driverIndexMap[uid] = i;
        }
      }
    }
  }

  /// Adds or updates a driver in the list while maintaining the O(1) index map.
  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver == null) return;
    _rebuildIndexMapIfNeeded();

    final int? existingIndex = _driverIndexMap[driver.uidDriver];
    if (existingIndex != null &&
        existingIndex < nearbyOnlineDriversList.length &&
        nearbyOnlineDriversList[existingIndex].uidDriver == driver.uidDriver) {
      nearbyOnlineDriversList[existingIndex] = driver;
    } else {
      _driverIndexMap[driver.uidDriver!] = nearbyOnlineDriversList.length;
      nearbyOnlineDriversList.add(driver);
    }
  }

  static void removeDriverFromList(String driverId) {
    _rebuildIndexMapIfNeeded();

    int? index = _driverIndexMap[driverId];

    // Validate index against actual element; fall back to linear search if list was modified externally
    if (index == null ||
        index >= nearbyOnlineDriversList.length ||
        nearbyOnlineDriversList[index].uidDriver != driverId) {
      index = nearbyOnlineDriversList
          .indexWhere((driver) => driver.uidDriver == driverId);
      if (index == -1) {
        index = null;
      }
    }

    if (index != null) {
      nearbyOnlineDriversList.removeAt(index);
      _driverIndexMap.clear();
      for (int i = 0; i < nearbyOnlineDriversList.length; i++) {
        final String? uid = nearbyOnlineDriversList[i].uidDriver;
        if (uid != null) {
          _driverIndexMap[uid] = i;
        }
      }
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    final String? driverId = nearbyOnlineDriverInformation.uidDriver;
    if (driverId == null) return;

    _rebuildIndexMapIfNeeded();

    int? index = _driverIndexMap[driverId];

    // Validate index against actual element; fall back to linear search if list was modified externally
    if (index == null ||
        index >= nearbyOnlineDriversList.length ||
        nearbyOnlineDriversList[index].uidDriver != driverId) {
      index = nearbyOnlineDriversList
          .indexWhere((driver) => driver.uidDriver == driverId);
      if (index != -1) {
        _driverIndexMap[driverId] = index;
      } else {
        index = null;
      }
    }

    if (index != null) {
      nearbyOnlineDriversList[index].latDriver =
          nearbyOnlineDriverInformation.latDriver;
      nearbyOnlineDriversList[index].lngDriver =
          nearbyOnlineDriverInformation.lngDriver;
    } else {
      print(
          "Driver with ID ${nearbyOnlineDriverInformation.uidDriver} not found in the list.");
    }
  }
}
