import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.nearbyOnlineDriversList.clear();
  });

  group('ManageDriversMethods tests', () {
    test('removeDriverFromList removes specified driver', () {
      final driver1 = OnlineNearbyDrivers(
          uidDriver: 'd1', latDriver: 10.0, lngDriver: 20.0);
      final driver2 = OnlineNearbyDrivers(
          uidDriver: 'd2', latDriver: 30.0, lngDriver: 40.0);

      ManageDriversMethods.nearbyOnlineDriversList.addAll([driver1, driver2]);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(2));

      ManageDriversMethods.removeDriverFromList('d1');

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver,
          equals('d2'));
    });

    test('updateOnlineNearbyDriversLocation updates coordinates correctly', () {
      final driver1 = OnlineNearbyDrivers(
          uidDriver: 'd1', latDriver: 10.0, lngDriver: 20.0);
      final driver2 = OnlineNearbyDrivers(
          uidDriver: 'd2', latDriver: 30.0, lngDriver: 40.0);

      ManageDriversMethods.nearbyOnlineDriversList.addAll([driver1, driver2]);

      final updatedDriver2 = OnlineNearbyDrivers(
          uidDriver: 'd2', latDriver: 35.0, lngDriver: 45.0);

      ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriver2);

      expect(ManageDriversMethods.nearbyOnlineDriversList[1].latDriver,
          equals(35.0));
      expect(ManageDriversMethods.nearbyOnlineDriversList[1].lngDriver,
          equals(45.0));
      expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver,
          equals(10.0));
    });
  });
}
