import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.nearbyOnlineDriversList.clear();
  });

  group('ManageDriversMethods tests', () {
    test('removeDriverFromList removes matching driver correctly', () {
      final driver1 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;
      final driver2 = OnlineNearbyDrivers()
        ..uidDriver = 'driver_2'
        ..latDriver = 30.0
        ..lngDriver = 40.0;

      ManageDriversMethods.nearbyOnlineDriversList.addAll([driver1, driver2]);

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 2);

      ManageDriversMethods.removeDriverFromList('driver_1');

      expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, 'driver_2');
    });

    test('updateOnlineNearbyDriversLocation updates driver position correctly', () {
      final driver = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 10.0
        ..lngDriver = 20.0;

      ManageDriversMethods.nearbyOnlineDriversList.add(driver);

      final updatedDriver = OnlineNearbyDrivers()
        ..uidDriver = 'driver_1'
        ..latDriver = 15.5
        ..lngDriver = 25.5;

      ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriver);

      expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, 15.5);
      expect(ManageDriversMethods.nearbyOnlineDriversList.first.lngDriver, 25.5);
    });
  });
}
