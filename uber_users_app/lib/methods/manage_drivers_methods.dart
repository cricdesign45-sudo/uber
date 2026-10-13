import 'package:uber_users_app/models/online_nearby_drivers.dart';

class ManageDriversMethods {
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];

  // Optimization: O(N) single-pass removal with removeWhere instead of double-pass indexWhere + removeAt
  static void removeDriverFromList(String driverId) {
    nearbyOnlineDriversList.removeWhere((driver) => driver.uidDriver == driverId);
  }

  static void updateOnlineNearbyDriversLocation(
      OnlineNearbyDrivers nearbyOnlineDriverInformation) {
    int index = nearbyOnlineDriversList.indexWhere((driver) =>
        driver.uidDriver == nearbyOnlineDriverInformation.uidDriver);

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
