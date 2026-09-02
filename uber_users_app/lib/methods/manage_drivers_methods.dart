import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  // Performance Optimization: Use removeWhere for single-pass removal.
  // Avoids running indexWhere scan followed by removeAt shift/bounds checks.
  static void removeDriverFromList(String driverId) {
    nearbyOnlineDriversList
        .removeWhere((driver) => driver.uidDriver == driverId);
  }

  // Performance Optimization: Direct indexed loop with early return.
  // Avoids allocating closure functions on high-frequency GeoFire location update events.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    for (int i = 0; i < nearbyOnlineDriversList.length; i++) {
      if (nearbyOnlineDriversList[i].uidDriver ==
          nearbyOnlineDriverInformation.uidDriver) {
        nearbyOnlineDriversList[i].latDriver =
            nearbyOnlineDriverInformation.latDriver;
        nearbyOnlineDriversList[i].lngDriver =
            nearbyOnlineDriverInformation.lngDriver;
        return;
      }
    }
  }
}
