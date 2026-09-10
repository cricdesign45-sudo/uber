import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  group('ManageDriversMethods tests', () {
    setUp(() {
      ManageDriversMethods.clear();
    });

    test('addDriverToList and updateOnlineNearbyDriversLocation updates existing driver location in O(1)', () {
      OnlineNearbyDrivers driver = OnlineNearbyDrivers(
        uidDriver: 'd1',
        latDriver: 10.0,
        lngDriver: 20.0,
      );
      ManageDriversMethods.addDriverToList(driver);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, 10.0);

      OnlineNearbyDrivers updatedDriver = OnlineNearbyDrivers(
        uidDriver: 'd1',
        latDriver: 15.0,
        lngDriver: 25.0,
      );
      ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriver);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, 15.0);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].lngDriver, 25.0);
    });

    test('removeDriverFromList removes driver by ID in O(1)', () {
      OnlineNearbyDrivers driver1 = OnlineNearbyDrivers(
        uidDriver: 'd1',
        latDriver: 10.0,
        lngDriver: 20.0,
      );
      OnlineNearbyDrivers driver2 = OnlineNearbyDrivers(
        uidDriver: 'd2',
        latDriver: 30.0,
        lngDriver: 40.0,
      );
      ManageDriversMethods.addDriverToList(driver1);
      ManageDriversMethods.addDriverToList(driver2);

      ManageDriversMethods.removeDriverFromList('d1');

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].uidDriver, 'd2');
    });
  });
}
