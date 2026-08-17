import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.clear();
  });

  group('ManageDriversMethods Performance & Functionality Tests', () {
    test('addDriverToList adds drivers and prevents duplicate entries', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'd1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;

      ManageDriversMethods.addDriverToList(driver1);
      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, equals('d1'));

      // Re-adding same driver should update location, not duplicate entry
      final driver1Updated = OnlineNearbyDrivers()
        ..uidDriver = 'd1'
        ..latDriver = 11.0
        ..lngDriver = 21.0;

      ManageDriversMethods.addDriverToList(driver1Updated);
      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, equals(11.0));
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.lngDriver, equals(21.0));
    });

    test('updateOnlineNearbyDriversLocation updates existing driver location in O(1)', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'd1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;

      ManageDriversMethods.addDriverToList(driver1);

      final locationUpdate = OnlineNearbyDrivers()
        ..uidDriver = 'd1'
        ..latDriver = 15.5
        ..lngDriver = 25.5;

      ManageDriversMethods.updateOnlineNearbyDriversLocation(locationUpdate);

      expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, equals(15.5));
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.lngDriver, equals(25.5));
    });

    test('removeDriverFromList removes specified driver in O(1)', () {
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

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(2));

      ManageDriversMethods.removeDriverFromList('d1');

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, equals('d2'));
    });
  });
}
