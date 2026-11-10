import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.nearbyOnlineDriversList.clear();
  });

  group('ManageDriversMethods Unit Tests', () {
    test('updates location of existing driver', () {
      final driver = OnlineNearbyDrivers()
        ..uidDriver = 'driver_123'
        ..latDriver = 31.5204
        ..lngDriver = 74.3587;
      ManageDriversMethods.nearbyOnlineDriversList.add(driver);

      final updatedInfo = OnlineNearbyDrivers()
        ..uidDriver = 'driver_123'
        ..latDriver = 31.5500
        ..lngDriver = 74.3700;
      ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedInfo);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, 31.5500);
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.lngDriver, 74.3700);
    });

    test('ignores update for non-existent driver without crashing', () {
      final updatedInfo = OnlineNearbyDrivers()
        ..uidDriver = 'driver_not_found'
        ..latDriver = 31.5500
        ..lngDriver = 74.3700;
      ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedInfo);

      expect(ManageDriversMethods.nearbyOnlineDriversList.isEmpty, isTrue);
    });

    test('removes driver from list correctly', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'd1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;
      final driver2 = OnlineNearbyDrivers()
        ..uidDriver = 'd2'
        ..latDriver = 11.0
        ..lngDriver = 21.0;
      ManageDriversMethods.nearbyOnlineDriversList.addAll([driver1, driver2]);

      ManageDriversMethods.removeDriverFromList('d1');

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, 'd2');
    });

    test('handles removal of non-existent driver gracefully', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'd1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;
      ManageDriversMethods.nearbyOnlineDriversList.add(driver1);

      ManageDriversMethods.removeDriverFromList('non_existent');

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, 'd1');
    });

    test('performance benchmark for repeated location updates', () {
      const count = 500;
      for (int i = 0; i < count; i++) {
        final driver = OnlineNearbyDrivers()
          ..uidDriver = 'driver_$i'
          ..latDriver = 30.0 + (i * 0.001)
          ..lngDriver = 70.0 + (i * 0.001);
        ManageDriversMethods.nearbyOnlineDriversList.add(driver);
      }

      final stopwatch = Stopwatch()..start();
      for (int k = 0; k < 1000; k++) {
        final updated = OnlineNearbyDrivers()
          ..uidDriver = 'driver_${k % count}'
          ..latDriver = 31.0
          ..lngDriver = 71.0;
        ManageDriversMethods.updateOnlineNearbyDriversLocation(updated);
      }
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
    });
  });
}
