import 'package:uber_users_app/models/online_nearby_drivers.dart';

/// Manages the list and fast map lookup of nearby online drivers.
///
/// Uses an internal Map ([_nearbyOnlineDriversMap]) for O(1) lookup, update,
/// and removal operations on driver data received from Geofire real-time streams.
class ManageDriversMethods {
  static final Map<String, OnlineNearbyDrivers> _nearbyOnlineDriversMap = {};

  /// Returns a list of all currently available nearby online drivers.
  static List<OnlineNearbyDrivers> get nearbyOnlineDriversList =>
      _nearbyOnlineDriversMap.values.toList();

  /// Adds or updates a nearby online driver in O(1) time complexity.
  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver != null) {
      _nearbyOnlineDriversMap[driver.uidDriver!] = driver;
    }
  }

  /// Removes a driver from nearby drivers in O(1) time complexity.
  static void removeDriverFromList(String driverId) {
    if (_nearbyOnlineDriversMap.containsKey(driverId)) {
      _nearbyOnlineDriversMap.remove(driverId);
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  /// Updates driver location in O(1) time complexity using Map lookup.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    final driverId = nearbyOnlineDriverInformation.uidDriver;
    if (driverId != null && _nearbyOnlineDriversMap.containsKey(driverId)) {
      _nearbyOnlineDriversMap[driverId]!.latDriver =
          nearbyOnlineDriverInformation.latDriver;
      _nearbyOnlineDriversMap[driverId]!.lngDriver =
          nearbyOnlineDriverInformation.lngDriver;
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  /// Clears all stored drivers.
  static void clear() {
    _nearbyOnlineDriversMap.clear();
  }
}
