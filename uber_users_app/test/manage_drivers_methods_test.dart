import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.clear();
  });

  group('ManageDriversMethods tests', () {
    test('addDriver adds drivers to nearbyOnlineDriversList', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 37.7749
        ..lngDriver = -122.4194;

      final driver2 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_2'
        ..latDriver = 37.7833
        ..lngDriver = -122.4167;

      ManageDriversMethods.addDriver(driver1);
      ManageDriversMethods.addDriver(driver2);

      final list = ManageDriversMethods.nearbyOnlineDriversList;
      expect(list.length, equals(2));
      expect(list.any((d) => d.uidDriver == 'driver_1'), isTrue);
      expect(list.any((d) => d.uidDriver == 'driver_2'), isTrue);
    });

    test('updateOnlineNearbyDriversLocation updates location in O(1)', () {
      final driver = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 37.7749
        ..lngDriver = -122.4194;

      ManageDriversMethods.addDriver(driver);

      final updatedDriver = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 37.8000
        ..lngDriver = -122.4000;

      ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriver);

      final list = ManageDriversMethods.nearbyOnlineDriversList;
      expect(list.length, equals(1));
      expect(list.first.latDriver, equals(37.8000));
      expect(list.first.lngDriver, equals(-122.4000));
    });

    test('removeDriverFromList removes driver in O(1)', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 37.7749
        ..lngDriver = -122.4194;

      final driver2 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_2'
        ..latDriver = 37.7833
        ..lngDriver = -122.4167;

      ManageDriversMethods.addDriver(driver1);
      ManageDriversMethods.addDriver(driver2);

      ManageDriversMethods.removeDriverFromList('driver_1');

      final list = ManageDriversMethods.nearbyOnlineDriversList;
      expect(list.length, equals(1));
      expect(list.first.uidDriver, equals('driver_2'));
    });

    test('clear removes all tracked drivers', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 37.7749
        ..lngDriver = -122.4194;

      ManageDriversMethods.addDriver(driver1);
      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));

      ManageDriversMethods.clear();
      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(0));
    });
  });
}
