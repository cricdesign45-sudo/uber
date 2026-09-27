import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  // Map driver ID to driver object and list index for strict O(1) lookups, updates, and removals.
  // Performance impact: Replaces O(N) linear scans with O(1) hash map lookups and O(1) swap-and-pop list removals,
  // preventing main-thread lag when real-time Geofire location updates arrive frequently.
  static final Map<String, OnlineNearbyDrivers> _nearbyOnlineDriversMap = {};
  static final Map<String, int> _driverIndexMap = {};

  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver == null) return;
    final driverId = driver.uidDriver!;

    if (_nearbyOnlineDriversMap.containsKey(driverId)) {
      updateOnlineNearbyDriversLocation(driver);
    } else {
      _nearbyOnlineDriversMap[driverId] = driver;
      _driverIndexMap[driverId] = nearbyOnlineDriversList.length;
      nearbyOnlineDriversList.add(driver);
    }
  }

  static void removeDriverFromList(String driverId) {
    final index = _driverIndexMap.remove(driverId);
    _nearbyOnlineDriversMap.remove(driverId);

    if (index != null && index < nearbyOnlineDriversList.length) {
      final lastIndex = nearbyOnlineDriversList.length - 1;
      if (index != lastIndex) {
        final lastDriver = nearbyOnlineDriversList[lastIndex];
        nearbyOnlineDriversList[index] = lastDriver;
        if (lastDriver.uidDriver != null) {
          _driverIndexMap[lastDriver.uidDriver!] = index;
        }
      }
      nearbyOnlineDriversList.removeLast(); // O(1) pop
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    if (nearbyOnlineDriverInformation.uidDriver == null) return;

    final existingDriver =
        _nearbyOnlineDriversMap[nearbyOnlineDriverInformation.uidDriver!];

    if (existingDriver != null) {
      // In-place property update on the referenced object in O(1) time
      existingDriver.latDriver = nearbyOnlineDriverInformation.latDriver;
      existingDriver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
    } else {
      print(
          "Driver with ID ${nearbyOnlineDriverInformation.uidDriver} not found in the list.");
    }
  }

  static void clearDriversList() {
    _nearbyOnlineDriversMap.clear();
    _driverIndexMap.clear();
    nearbyOnlineDriversList.clear();
  }
}
