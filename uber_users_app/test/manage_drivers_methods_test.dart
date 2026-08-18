import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  group('ManageDriversMethods Performance & Correctness Tests', () {
    setUp(() {
      ManageDriversMethods.clearDrivers();
    });

    test('addDriverToList adds driver to list and map', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'd1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;

      ManageDriversMethods.addDriverToList(driver1);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, 'd1');
    });

    test('removeDriverFromList removes driver correctly in O(1)', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'd1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;
      final driver2 = OnlineNearbyDrivers()
        ..uidDriver = 'd2'
        ..latDriver = 30.0
        ..lngDriver = 40.0;

      ManageDriversMethods.addDriverToList(driver1);
      ManageDriversMethods.addDriverToList(driver2);

      ManageDriversMethods.removeDriverFromList('d1');

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, 'd2');
    });

    test('updateOnlineNearbyDriversLocation updates driver location in O(1)', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'd1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;
      ManageDriversMethods.addDriverToList(driver1);

      final updatedDriver = OnlineNearbyDrivers()
        ..uidDriver = 'd1'
        ..latDriver = 15.0
        ..lngDriver = 25.0;
      ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriver);

      expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, 15.0);
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.lngDriver, 25.0);
    });

    test('fallback works for drivers directly added to nearbyOnlineDriversList', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'd1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;
      ManageDriversMethods.nearbyOnlineDriversList.add(driver1);

      final updatedDriver = OnlineNearbyDrivers()
        ..uidDriver = 'd1'
        ..latDriver = 15.0
        ..lngDriver = 25.0;
      ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriver);

      expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, 15.0);

      ManageDriversMethods.removeDriverFromList('d1');
      expect(ManageDriversMethods.nearbyOnlineDriversList.isEmpty, true);
    });
  });
}
