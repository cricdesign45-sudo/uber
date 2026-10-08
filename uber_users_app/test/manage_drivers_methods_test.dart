import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.clearList();
  });

  group('ManageDriversMethods O(1) Optimization Tests', () {
    test('addDriverToList adds new drivers correctly', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;

      final driver2 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_2'
        ..latDriver = 15.0
        ..lngDriver = 25.0;

      ManageDriversMethods.addDriverToList(driver1);
      ManageDriversMethods.addDriverToList(driver2);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 2);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].uidDriver, 'driver_1');
      expect(ManageDriversMethods.nearbyOnlineDriversList[1].uidDriver, 'driver_2');
    });

    test('addDriverToList updates existing driver position without duplicate addition', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;

      ManageDriversMethods.addDriverToList(driver1);

      final updatedDriver1 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 12.34
        ..lngDriver = 56.78;

      ManageDriversMethods.addDriverToList(updatedDriver1);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, 12.34);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].lngDriver, 56.78);
    });

    test('updateOnlineNearbyDriversLocation updates driver position in O(1)', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;

      ManageDriversMethods.addDriverToList(driver1);

      final updateInfo = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 30.0
        ..lngDriver = 40.0;

      ManageDriversMethods.updateOnlineNearbyDriversLocation(updateInfo);

      expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, 30.0);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].lngDriver, 40.0);
    });

    test('removeDriverFromList removes driver and keeps index map in sync', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;

      final driver2 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_2'
        ..latDriver = 15.0
        ..lngDriver = 25.0;

      ManageDriversMethods.addDriverToList(driver1);
      ManageDriversMethods.addDriverToList(driver2);

      ManageDriversMethods.removeDriverFromList('driver_1');

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].uidDriver, 'driver_2');

      // Verify that remaining driver can still be updated via index map
      final updateInfo = OnlineNearbyDrivers()
        ..uidDriver = 'driver_2'
        ..latDriver = 99.0
        ..lngDriver = 88.0;

      ManageDriversMethods.updateOnlineNearbyDriversLocation(updateInfo);

      expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, 99.0);
    });
  });
}
