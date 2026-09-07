import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  group('ManageDriversMethods tests', () {
    setUp(() {
      ManageDriversMethods.nearbyOnlineDriversList.clear();
      ManageDriversMethods.nearbyOnlineDriversMap.clear();
    });

    test('addDriverToList adds driver to both list and map', () {
      OnlineNearbyDrivers driver = OnlineNearbyDrivers();
      driver.uidDriver = "driver_123";
      driver.latDriver = 37.7749;
      driver.lngDriver = -122.4194;

      ManageDriversMethods.addDriverToList(driver);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversMap.containsKey("driver_123"), true);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, 37.7749);
    });

    test('updateOnlineNearbyDriversLocation updates driver position in O(1)', () {
      OnlineNearbyDrivers driver = OnlineNearbyDrivers();
      driver.uidDriver = "driver_123";
      driver.latDriver = 37.7749;
      driver.lngDriver = -122.4194;
      ManageDriversMethods.addDriverToList(driver);

      OnlineNearbyDrivers updateInfo = OnlineNearbyDrivers();
      updateInfo.uidDriver = "driver_123";
      updateInfo.latDriver = 37.7750;
      updateInfo.lngDriver = -122.4195;

      ManageDriversMethods.updateOnlineNearbyDriversLocation(updateInfo);

      expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, 37.7750);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].lngDriver, -122.4195);
    });

    test('removeDriverFromList removes driver from both list and map', () {
      OnlineNearbyDrivers driver1 = OnlineNearbyDrivers();
      driver1.uidDriver = "driver_1";

      OnlineNearbyDrivers driver2 = OnlineNearbyDrivers();
      driver2.uidDriver = "driver_2";

      ManageDriversMethods.addDriverToList(driver1);
      ManageDriversMethods.addDriverToList(driver2);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 2);

      ManageDriversMethods.removeDriverFromList("driver_1");

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].uidDriver, "driver_2");
      expect(ManageDriversMethods.nearbyOnlineDriversMap.containsKey("driver_1"), false);
    });
  });
}
