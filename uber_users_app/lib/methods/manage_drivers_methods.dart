import 'package:uber_users_app/models/online_nearby_drivers.dart';

/// [ManageDriversMethods] manages online nearby drivers state and location updates.
///
/// Optimization: Uses a Map index `_driverIndexMap` to achieve O(1) time complexity for
/// lookup, update, and removal operations instead of O(N) linear searches (`indexWhere`).
class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];
  static final Map<String, int> _driverIndexMap = {};

  /// Clears the drivers list and index map (useful for test setup or resetting state).
  static void clear() {
    nearbyOnlineDriversList.clear();
    _driverIndexMap.clear();
  }

  /// Adds a driver to the list and updates the index map in O(1) time.
  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver == null) return;

    // If driver already exists, update their location instead of adding duplicate
    if (_driverIndexMap.containsKey(driver.uidDriver) &&
        _isValidIndex(_driverIndexMap[driver.uidDriver], driver.uidDriver!)) {
      updateOnlineNearbyDriversLocation(driver);
      return;
    }

    nearbyOnlineDriversList.add(driver);
    _driverIndexMap[driver.uidDriver!] = nearbyOnlineDriversList.length - 1;
  }

  /// Removes driver from the list in O(1) time using index lookup and swap-with-last.
  static void removeDriverFromList(String driverId) {
    final index = _driverIndexMap[driverId];

    if (_isValidIndex(index, driverId)) {
      int lastIndex = nearbyOnlineDriversList.length - 1;
      if (index! != lastIndex) {
        // Swap with last element to maintain contiguous indices for fast removal
        OnlineNearbyDrivers lastDriver = nearbyOnlineDriversList[lastIndex];
        nearbyOnlineDriversList[index] = lastDriver;
        if (lastDriver.uidDriver != null) {
          _driverIndexMap[lastDriver.uidDriver!] = index;
        }
      }
      nearbyOnlineDriversList.removeLast();
      _driverIndexMap.remove(driverId);
    } else {
      // Fallback in case of out-of-sync state
      int fallbackIndex = nearbyOnlineDriversList
          .indexWhere((driver) => driver.uidDriver == driverId);
      if (fallbackIndex != -1) {
        nearbyOnlineDriversList.removeAt(fallbackIndex);
        _rebuildIndexMap();
      } else {
        print("Driver with ID $driverId not found in the list.");
      }
    }
  }

  /// Updates driver location in O(1) constant time.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    final driverId = nearbyOnlineDriverInformation.uidDriver;
    if (driverId == null) return;

    final index = _driverIndexMap[driverId];

    if (_isValidIndex(index, driverId)) {
      nearbyOnlineDriversList[index!].latDriver =
          nearbyOnlineDriverInformation.latDriver;
      nearbyOnlineDriversList[index].lngDriver =
          nearbyOnlineDriverInformation.lngDriver;
    } else {
      // Fallback in case of out-of-sync state
      int fallbackIndex = nearbyOnlineDriversList.indexWhere(
          (driver) => driver.uidDriver == driverId);

      if (fallbackIndex != -1) {
        nearbyOnlineDriversList[fallbackIndex].latDriver =
            nearbyOnlineDriverInformation.latDriver;
        nearbyOnlineDriversList[fallbackIndex].lngDriver =
            nearbyOnlineDriverInformation.lngDriver;
        _driverIndexMap[driverId] = fallbackIndex;
      } else {
        print(
            "Driver with ID $driverId not found in the list.");
      }
    }
  }

  /// Helper to validate index map entry matches the list element.
  static bool _isValidIndex(int? index, String driverId) {
    if (index == null || index < 0 || index >= nearbyOnlineDriversList.length) {
      return false;
    }
    return nearbyOnlineDriversList[index].uidDriver == driverId;
  }

  /// Rebuilds index map if list was directly modified externally or out of sync.
  static void _rebuildIndexMap() {
    _driverIndexMap.clear();
    for (int i = 0; i < nearbyOnlineDriversList.length; i++) {
      final uid = nearbyOnlineDriversList[i].uidDriver;
      if (uid != null) {
        _driverIndexMap[uid] = i;
      }
    }
  }
}
