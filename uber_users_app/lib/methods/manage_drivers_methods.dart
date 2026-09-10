import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  // Static list maintained in sync with Map for O(1) lookup and O(1) indexed list access
  static final List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];
  static final Map<String, int> _driverIndexMap = {};

  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver != null) {
      if (_driverIndexMap.containsKey(driver.uidDriver!)) {
        // Driver already exists, update position
        int index = _driverIndexMap[driver.uidDriver!]!;
        nearbyOnlineDriversList[index] = driver;
      } else {
        // New driver, append to list and record index in map
        _driverIndexMap[driver.uidDriver!] = nearbyOnlineDriversList.length;
        nearbyOnlineDriversList.add(driver);
      }
    }
  }

  static void removeDriverFromList(String driverId) {
    // O(1) removal using swap-with-last strategy
    if (_driverIndexMap.containsKey(driverId)) {
      int indexToRemove = _driverIndexMap[driverId]!;
      int lastIndex = nearbyOnlineDriversList.length - 1;

      if (indexToRemove != lastIndex) {
        OnlineNearbyDrivers lastDriver = nearbyOnlineDriversList[lastIndex];
        nearbyOnlineDriversList[indexToRemove] = lastDriver;
        if (lastDriver.uidDriver != null) {
          _driverIndexMap[lastDriver.uidDriver!] = indexToRemove;
        }
      }

      nearbyOnlineDriversList.removeLast();
      _driverIndexMap.remove(driverId);
    } else {
      print("Driver with ID $driverId not found in the list.");
    }
  }

  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    String? driverId = nearbyOnlineDriverInformation.uidDriver;
    // O(1) lookup using Map key instead of linear O(N) indexWhere search
    if (driverId != null && _driverIndexMap.containsKey(driverId)) {
      int index = _driverIndexMap[driverId]!;
      nearbyOnlineDriversList[index].latDriver =
          nearbyOnlineDriverInformation.latDriver;
      nearbyOnlineDriversList[index].lngDriver =
          nearbyOnlineDriverInformation.lngDriver;
    } else {
      print(
          "Driver with ID ${nearbyOnlineDriverInformation.uidDriver} not found in the list.");
    }
  }

  static void clear() {
    nearbyOnlineDriversList.clear();
    _driverIndexMap.clear();
  }
}
