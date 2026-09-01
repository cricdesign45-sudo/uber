import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  group('ManageDriversMethods tests', () {
    setUp(() {
      ManageDriversMethods.clear();
    });

    test('addDriverToList adds drivers and prevents duplicates', () {
      OnlineNearbyDrivers driver1 = OnlineNearbyDrivers();
      driver1.uidDriver = 'driver_1';
      driver1.latDriver = 10.0;
      driver1.lngDriver = 20.0;

      ManageDriversMethods.addDriverToList(driver1);
      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, equals(10.0));

      // Adding existing driver updates location instead of appending duplicate
      OnlineNearbyDrivers driver1Updated = OnlineNearbyDrivers();
      driver1Updated.uidDriver = 'driver_1';
      driver1Updated.latDriver = 15.0;
      driver1Updated.lngDriver = 25.0;

      ManageDriversMethods.addDriverToList(driver1Updated);
      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, equals(15.0));
    });

    test('updateOnlineNearbyDriversLocation updates location in O(1)', () {
      OnlineNearbyDrivers driver1 = OnlineNearbyDrivers();
      driver1.uidDriver = 'driver_1';
      driver1.latDriver = 10.0;
      driver1.lngDriver = 20.0;

      OnlineNearbyDrivers driver2 = OnlineNearbyDrivers();
      driver2.uidDriver = 'driver_2';
      driver2.latDriver = 30.0;
      driver2.lngDriver = 40.0;

      ManageDriversMethods.addDriverToList(driver1);
      ManageDriversMethods.addDriverToList(driver2);

      OnlineNearbyDrivers updateDriver1 = OnlineNearbyDrivers();
      updateDriver1.uidDriver = 'driver_1';
      updateDriver1.latDriver = 12.0;
      updateDriver1.lngDriver = 22.0;

      ManageDriversMethods.updateOnlineNearbyDriversLocation(updateDriver1);

      expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, equals(12.0));
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].lngDriver, equals(22.0));
      expect(ManageDriversMethods.nearbyOnlineDriversList[1].latDriver, equals(30.0));
    });

    test('removeDriverFromList removes driver and keeps indices synced', () {
      OnlineNearbyDrivers driver1 = OnlineNearbyDrivers();
      driver1.uidDriver = 'driver_1';
      OnlineNearbyDrivers driver2 = OnlineNearbyDrivers();
      driver2.uidDriver = 'driver_2';
      OnlineNearbyDrivers driver3 = OnlineNearbyDrivers();
      driver3.uidDriver = 'driver_3';

      ManageDriversMethods.addDriverToList(driver1);
      ManageDriversMethods.addDriverToList(driver2);
      ManageDriversMethods.addDriverToList(driver3);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(3));

      ManageDriversMethods.removeDriverFromList('driver_1');
      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(2));

      // Update remaining driver location to verify index map integrity
      OnlineNearbyDrivers updateDriver3 = OnlineNearbyDrivers();
      updateDriver3.uidDriver = 'driver_3';
      updateDriver3.latDriver = 99.0;
      updateDriver3.lngDriver = 99.0;

      ManageDriversMethods.updateOnlineNearbyDriversLocation(updateDriver3);
      final driver3InList = ManageDriversMethods.nearbyOnlineDriversList
          .firstWhere((d) => d.uidDriver == 'driver_3');
      expect(driver3InList.latDriver, equals(99.0));
    });
  });
}
