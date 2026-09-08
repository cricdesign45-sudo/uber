import 'package:uber_users_app/models/online_nearby_drivers.dart';

/// Manages active nearby online drivers in memory.
///
/// Uses an underlying [Map] keyed by driver UID to achieve O(1) constant-time
/// updates, removals, and additions during high-frequency location streaming from Geofire.
class ManageDriversMethods {
  static final Map<String, OnlineNearbyDrivers> _nearbyOnlineDriversMap = {};

  /// Returns an [Iterable] of all currently nearby online drivers without allocating a new list.
  static Iterable<OnlineNearbyDrivers> get nearbyOnlineDriversList =>
      _nearbyOnlineDriversMap.values;

  /// Adds or updates a driver in the nearby drivers map in O(1) time.
  static void addDriver(OnlineNearbyDrivers driver) {
    if (driver.uidDriver != null) {
      _nearbyOnlineDriversMap[driver.uidDriver!] = driver;
    }
  }

  /// Removes a driver with [driverId] from the map in O(1) time.
  static void removeDriverFromList(String driverId) {
    if (_nearbyOnlineDriversMap.remove(driverId) == null) {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  /// Updates the latitude and longitude of an existing driver in O(1) time.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    final driverId = nearbyOnlineDriverInformation.uidDriver;
    if (driverId != null && _nearbyOnlineDriversMap.containsKey(driverId)) {
      _nearbyOnlineDriversMap[driverId]!.latDriver =
          nearbyOnlineDriverInformation.latDriver;
      _nearbyOnlineDriversMap[driverId]!.lngDriver =
          nearbyOnlineDriverInformation.lngDriver;
    } else {
      print(
          "Driver with ID ${nearbyOnlineDriverInformation.uidDriver} not found in the list.");
    }
  }

  /// Clears all tracked drivers from memory.
  static void clear() {
    _nearbyOnlineDriversMap.clear();
  }
}
