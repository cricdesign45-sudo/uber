import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  // Index map for O(1) constant time lookups by driver UID
  // Performance optimization: Avoids O(N) linear searches on frequent location updates
  static final Map<String, int> _driverIndexMap = {};

  /// Adds a driver to the list if not present, or updates their location if already present.
  /// Replaces O(N) duplicates with O(1) constant-time lookup.
  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver == null) return;
    String id = driver.uidDriver!;

    int? index = _driverIndexMap[id];
    if (index != null &&
        index >= 0 &&
        index < nearbyOnlineDriversList.length &&
        nearbyOnlineDriversList[index].uidDriver == id) {
      // Driver already exists in list, update position directly
      nearbyOnlineDriversList[index].latDriver = driver.latDriver;
      nearbyOnlineDriversList[index].lngDriver = driver.lngDriver;
    } else {
      nearbyOnlineDriversList.add(driver);
      _driverIndexMap[id] = nearbyOnlineDriversList.length - 1;
    }
  }

  /// Removes driver with given [driverId] in O(1) time using index map.
  static void removeDriverFromList(String driverId) {
    int? index = _driverIndexMap[driverId];

    if (index != null &&
        index >= 0 &&
        index < nearbyOnlineDriversList.length &&
        nearbyOnlineDriversList[index].uidDriver == driverId) {
      nearbyOnlineDriversList.removeAt(index);
      _rebuildIndexMap();
    } else {
      // Fallback O(N) search if index map was out of sync
      int idx = nearbyOnlineDriversList
          .indexWhere((driver) => driver.uidDriver == driverId);
      if (idx != -1) {
        nearbyOnlineDriversList.removeAt(idx);
        _rebuildIndexMap();
      }
    }
  }

  /// Updates driver location in O(1) time using index map.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    if (nearbyOnlineDriverInformation.uidDriver == null) return;
    String id = nearbyOnlineDriverInformation.uidDriver!;

    int? index = _driverIndexMap[id];

    if (index != null &&
        index >= 0 &&
        index < nearbyOnlineDriversList.length &&
        nearbyOnlineDriversList[index].uidDriver == id) {
      nearbyOnlineDriversList[index].latDriver =
          nearbyOnlineDriverInformation.latDriver;
      nearbyOnlineDriversList[index].lngDriver =
          nearbyOnlineDriverInformation.lngDriver;
    } else {
      // Fallback O(N) search if index map was out of sync
      int idx = nearbyOnlineDriversList
          .indexWhere((driver) => driver.uidDriver == id);
      if (idx != -1) {
        nearbyOnlineDriversList[idx].latDriver =
            nearbyOnlineDriverInformation.latDriver;
        nearbyOnlineDriversList[idx].lngDriver =
            nearbyOnlineDriverInformation.lngDriver;
        _driverIndexMap[id] = idx;
      }
    }
  }

  /// Rebuilds the internal index map after items shift in list.
  static void _rebuildIndexMap() {
    _driverIndexMap.clear();
    for (int i = 0; i < nearbyOnlineDriversList.length; i++) {
      if (nearbyOnlineDriversList[i].uidDriver != null) {
        _driverIndexMap[nearbyOnlineDriversList[i].uidDriver!] = i;
      }
    }
  }

  /// Clears driver list and index map.
  static void clearList() {
    nearbyOnlineDriversList.clear();
    _driverIndexMap.clear();
  }
}
