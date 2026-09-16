import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  group('ManageDriversMethods Tests', () {
    setUp(() {
      ManageDriversMethods.clearDrivers();
    });

    test('addDriver, removeDriverFromList and updateOnlineNearbyDriversLocation', () {
      var driver1 = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 1.0..lngDriver = 1.0;
      var driver2 = OnlineNearbyDrivers()..uidDriver = 'd2'..latDriver = 2.0..lngDriver = 2.0;

      ManageDriversMethods.addDriver(driver1);
      ManageDriversMethods.addDriver(driver2);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(2));

      // Test update location
      var updatedDriver1 = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 3.0..lngDriver = 4.0;
      ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriver1);

      expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, equals(3.0));
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.lngDriver, equals(4.0));

      // Test remove
      ManageDriversMethods.removeDriverFromList('d1');

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, equals('d2'));
    });

    test('Benchmark lookup / update performance', () {
      // Benchmark 2000 drivers lookup/update
      final int count = 2000;
      for (int i = 0; i < count; i++) {
        var driver = OnlineNearbyDrivers()
          ..uidDriver = 'driver_$i'
          ..latDriver = i * 0.01
          ..lngDriver = i * 0.01;
        ManageDriversMethods.addDriver(driver);
      }

      final stopwatch = Stopwatch()..start();
      for (int i = 0; i < 500; i++) {
        var updated = OnlineNearbyDrivers()
          ..uidDriver = 'driver_${i * 2}'
          ..latDriver = 99.0
          ..lngDriver = 99.0;
        ManageDriversMethods.updateOnlineNearbyDriversLocation(updated);
      }
      stopwatch.stop();
      print('Execution time for 500 updates among 2000 drivers: ${stopwatch.elapsedMicroseconds} us');
    });
  });
}
