import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  // Performance Optimization:
  // Maintain an index lookup map to provide O(1) access when updating or removing
  // drivers from the GeoFire stream instead of running an O(n) `indexWhere` scan.
  static final Map<String, int> _driverIndexMap = {};

  /// Rebuilds or synchronizes the driver index map.
  static void _rebuildIndexMap() {
    _driverIndexMap.clear();
    for (int i = 0; i < nearbyOnlineDriversList.length; i++) {
      final id = nearbyOnlineDriversList[i].uidDriver;
      if (id != null) {
        _driverIndexMap[id] = i;
      }
    }
  }

  /// Removes a driver with [driverId] from [nearbyOnlineDriversList] and updates indices.
  static void removeDriverFromList(String driverId) {
    // Fast path: check index map first for O(1) lookup
    int? cachedIndex = _driverIndexMap[driverId];
    int index = -1;

    if (cachedIndex != null &&
        cachedIndex < nearbyOnlineDriversList.length &&
        nearbyOnlineDriversList[cachedIndex].uidDriver == driverId) {
      index = cachedIndex;
    } else {
      // Fallback in case external modifications bypassed the index map
      index = nearbyOnlineDriversList
          .indexWhere((driver) => driver.uidDriver == driverId);
    }

    if (index != -1) {
      // Ensure the index is valid
      nearbyOnlineDriversList.removeAt(index);
      _rebuildIndexMap();
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  /// Updates driver location in O(1) time using the cached index lookup.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    final driverId = nearbyOnlineDriverInformation.uidDriver;
    int index = -1;

    if (driverId != null) {
      int? cachedIndex = _driverIndexMap[driverId];
      if (cachedIndex != null &&
          cachedIndex < nearbyOnlineDriversList.length &&
          nearbyOnlineDriversList[cachedIndex].uidDriver == driverId) {
        index = cachedIndex;
      }
    }

    if (index == -1) {
      // Fallback to indexWhere if not found in map (e.g. driver was added directly to list)
      index = nearbyOnlineDriversList.indexWhere((driver) =>
          driver.uidDriver == nearbyOnlineDriverInformation.uidDriver);
      if (index != -1 && driverId != null) {
        // Cache the discovered index for subsequent O(1) updates
        _driverIndexMap[driverId] = index;
      }
    }

    if (index != -1) {
      // Ensure the index is valid
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
