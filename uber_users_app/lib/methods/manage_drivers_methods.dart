import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  /// Removes a driver from the nearby drivers list using single-pass predicate removal [removeWhere]
  /// instead of searching with [indexWhere] and then performing list shifting with [removeAt].
  static void removeDriverFromList(String driverId) {
    nearbyOnlineDriversList.removeWhere((driver) => driver.uidDriver == driverId);
  }

  /// Updates driver location in-place upon finding a match.
  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    for (int i = 0; i < nearbyOnlineDriversList.length; i++) {
      if (nearbyOnlineDriversList[i].uidDriver == nearbyOnlineDriverInformation.uidDriver) {
        nearbyOnlineDriversList[i].latDriver =
            nearbyOnlineDriverInformation.latDriver;
        nearbyOnlineDriversList[i].lngDriver =
            nearbyOnlineDriverInformation.lngDriver;
        return; // Early exit once target driver is updated
      }
    }
  }
}
