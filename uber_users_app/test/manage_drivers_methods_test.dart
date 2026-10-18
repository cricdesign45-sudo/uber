import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.nearbyOnlineDriversList.clear();
    ManageDriversMethods.nearbyOnlineDriversMap.clear();
  });

  group('ManageDriversMethods tests', () {
    test('addDriverToList adds driver to both list and map', () {
      final driver = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 12.34
        ..lngDriver = 56.78;

      ManageDriversMethods.addDriverToList(driver);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
      expect(ManageDriversMethods.nearbyOnlineDriversMap['driver_1'], equals(driver));
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, equals(12.34));
    });

    test('updateOnlineNearbyDriversLocation updates location in O(1)', () {
      final driver = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 12.34
        ..lngDriver = 56.78;

      ManageDriversMethods.addDriverToList(driver);

      final updatedDriverInfo = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 12.99
        ..lngDriver = 56.99;

      ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriverInfo);

      expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, equals(12.99));
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.lngDriver, equals(56.99));
      expect(ManageDriversMethods.nearbyOnlineDriversMap['driver_1']!.latDriver, equals(12.99));
    });

    test('removeDriverFromList removes driver from both list and map in O(1)', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;
      final driver2 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_2'
        ..latDriver = 30.0
        ..lngDriver = 40.0;

      ManageDriversMethods.addDriverToList(driver1);
      ManageDriversMethods.addDriverToList(driver2);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(2));

      ManageDriversMethods.removeDriverFromList('driver_1');

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, equals('driver_2'));
      expect(ManageDriversMethods.nearbyOnlineDriversMap.containsKey('driver_1'), isFalse);
    });
  });
}
