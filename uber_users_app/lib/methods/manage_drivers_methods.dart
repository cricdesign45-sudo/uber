import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];
  static final Map<String, OnlineNearbyDrivers> nearbyOnlineDriversMap = {};

  /// Adds a driver to the nearby drivers map and list for fast O(1) lookup.
  static void addDriverToList(OnlineNearbyDrivers driver) {
    if (driver.uidDriver == null) return;
    nearbyOnlineDriversMap[driver.uidDriver!] = driver;
    int index = nearbyOnlineDriversList
        .indexWhere((d) => d.uidDriver == driver.uidDriver);
    if (index != -1) {
      nearbyOnlineDriversList[index] = driver;
    } else {
      nearbyOnlineDriversList.add(driver);
    }
  }

  /// Removes a driver by ID from the map and list using O(1) map lookup.
  static void removeDriverFromList(String driverId) {
    OnlineNearbyDrivers? removedDriver = nearbyOnlineDriversMap.remove(driverId);

    if (removedDriver != null) {
      nearbyOnlineDriversList.remove(removedDriver);
    } else {
      int index = nearbyOnlineDriversList
          .indexWhere((driver) => driver.uidDriver == driverId);

      if (index != -1) {
        nearbyOnlineDriversList.removeAt(index);
      } else {
        print("Driver with ID $driverId not found in the list.");
      }
    }
  }

  /// Updates driver location using O(1) map lookup instead of O(N) linear scan.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    String? driverId = nearbyOnlineDriverInformation.uidDriver;
    OnlineNearbyDrivers? driver =
        driverId != null ? nearbyOnlineDriversMap[driverId] : null;

    if (driver != null) {
      // O(1) update on the shared object reference
      driver.latDriver = nearbyOnlineDriverInformation.latDriver;
      driver.lngDriver = nearbyOnlineDriverInformation.lngDriver;
    } else {
      int index = nearbyOnlineDriversList.indexWhere((driver) =>
          driver.uidDriver == nearbyOnlineDriverInformation.uidDriver);

      if (index != -1) {
        nearbyOnlineDriversList[index].latDriver =
            nearbyOnlineDriverInformation.latDriver;
        nearbyOnlineDriversList[index].lngDriver =
            nearbyOnlineDriverInformation.lngDriver;
        if (driverId != null) {
          nearbyOnlineDriversMap[driverId] = nearbyOnlineDriversList[index];
        }
      } else {
        print(
            "Driver with ID ${nearbyOnlineDriverInformation.uidDriver} not found in the list.");
      }
    }
  }
}
