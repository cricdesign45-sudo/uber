import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  group('ManageDriversMethods O(1) optimization tests', () {
    setUp(() {
      ManageDriversMethods.clear();
    });

    test('addDriverToList adds driver and preserves list getter output', () {
      final driver = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 37.7749
        ..lngDriver = -122.4194;

      ManageDriversMethods.addDriverToList(driver);

      final list = ManageDriversMethods.nearbyOnlineDriversList;
      expect(list.length, equals(1));
      expect(list.first.uidDriver, equals('driver_1'));
      expect(list.first.latDriver, equals(37.7749));
    });

    test('updateOnlineNearbyDriversLocation updates driver location in O(1)', () {
      final driver = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 37.7749
        ..lngDriver = -122.4194;

      ManageDriversMethods.addDriverToList(driver);

      final updatedDriver = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 37.7800
        ..lngDriver = -122.4200;

      ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriver);

      final list = ManageDriversMethods.nearbyOnlineDriversList;
      expect(list.length, equals(1));
      expect(list.first.latDriver, equals(37.7800));
      expect(list.first.lngDriver, equals(-122.4200));
    });

    test('removeDriverFromList removes driver in O(1)', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 37.7749
        ..lngDriver = -122.4194;

      final driver2 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_2'
        ..latDriver = 37.7750
        ..lngDriver = -122.4195;

      ManageDriversMethods.addDriverToList(driver1);
      ManageDriversMethods.addDriverToList(driver2);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(2));

      ManageDriversMethods.removeDriverFromList('driver_1');

      final list = ManageDriversMethods.nearbyOnlineDriversList;
      expect(list.length, equals(1));
      expect(list.first.uidDriver, equals('driver_2'));
    });
  });
}
