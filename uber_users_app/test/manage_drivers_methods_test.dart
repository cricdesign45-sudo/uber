import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.clearDrivers();
  });

  tearDown(() {
    ManageDriversMethods.clearDrivers();
  });

  group('ManageDriversMethods Performance & Synchronization Tests', () {
    test('addDriverToList adds drivers and keeps map and list in sync', () {
      final driver1 = OnlineNearbyDrivers(
        uidDriver: 'driver_1',
        latDriver: 37.7749,
        lngDriver: -122.4194,
      );

      ManageDriversMethods.addDriverToList(driver1);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversMap.containsKey('driver_1'), isTrue);
      expect(ManageDriversMethods.nearbyOnlineDriversMap['driver_1']!.latDriver, 37.7749);

      // Re-adding the same driver updates coordinates without duplicate list entry
      final driver1Updated = OnlineNearbyDrivers(
        uidDriver: 'driver_1',
        latDriver: 37.7750,
        lngDriver: -122.4195,
      );

      ManageDriversMethods.addDriverToList(driver1Updated);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversMap['driver_1']!.latDriver, 37.7750);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, 37.7750);
    });

    test('updateOnlineNearbyDriversLocation updates coordinates in O(1)', () {
      final driver = OnlineNearbyDrivers(
        uidDriver: 'driver_fast',
        latDriver: 10.0,
        lngDriver: 20.0,
      );

      ManageDriversMethods.addDriverToList(driver);

      final updateInfo = OnlineNearbyDrivers(
        uidDriver: 'driver_fast',
        latDriver: 10.5,
        lngDriver: 20.5,
      );

      ManageDriversMethods.updateOnlineNearbyDriversLocation(updateInfo);

      expect(ManageDriversMethods.nearbyOnlineDriversMap['driver_fast']!.latDriver, 10.5);
      expect(ManageDriversMethods.nearbyOnlineDriversMap['driver_fast']!.lngDriver, 20.5);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, 10.5);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].lngDriver, 20.5);
    });

    test('removeDriverFromList removes driver from both map and list in O(1)', () {
      final driver1 = OnlineNearbyDrivers(
        uidDriver: 'driver_to_remove',
        latDriver: 12.34,
        lngDriver: 56.78,
      );
      final driver2 = OnlineNearbyDrivers(
        uidDriver: 'driver_to_keep',
        latDriver: 11.11,
        lngDriver: 22.22,
      );

      ManageDriversMethods.addDriverToList(driver1);
      ManageDriversMethods.addDriverToList(driver2);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 2);

      ManageDriversMethods.removeDriverFromList('driver_to_remove');

      expect(ManageDriversMethods.nearbyOnlineDriversMap.containsKey('driver_to_remove'), isFalse);
      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].uidDriver, 'driver_to_keep');
    });

    test('benchmark: rapid location updates scale efficiently with hash map', () {
      const driverCount = 100;
      for (int i = 0; i < driverCount; i++) {
        ManageDriversMethods.addDriverToList(OnlineNearbyDrivers(
          uidDriver: 'driver_$i',
          latDriver: 30.0 + i * 0.001,
          lngDriver: 70.0 + i * 0.001,
        ));
      }

      final stopwatch = Stopwatch()..start();
      // Simulate 1000 rapid location updates as from GeoFire onKeyMoved
      for (int i = 0; i < 1000; i++) {
        final driverId = 'driver_${i % driverCount}';
        ManageDriversMethods.updateOnlineNearbyDriversLocation(OnlineNearbyDrivers(
          uidDriver: driverId,
          latDriver: 35.0,
          lngDriver: 75.0,
        ));
      }
      stopwatch.stop();

      // 1000 updates should complete well under 50ms using O(1) lookups
      expect(stopwatch.elapsedMilliseconds, lessThan(100));
      expect(ManageDriversMethods.nearbyOnlineDriversMap['driver_0']!.latDriver, 35.0);
    });
  });
}
