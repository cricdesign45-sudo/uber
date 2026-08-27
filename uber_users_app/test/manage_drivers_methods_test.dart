import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  test('removeDriverFromList removes driver efficiently', () {
    final driver1 = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 1.0..lngDriver = 1.0;
    final driver2 = OnlineNearbyDrivers()..uidDriver = 'd2'..latDriver = 2.0..lngDriver = 2.0;

    ManageDriversMethods.nearbyOnlineDriversList = [driver1, driver2];

    ManageDriversMethods.removeDriverFromList('d1');

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, equals('d2'));
  });

  test('updateOnlineNearbyDriversLocation updates location', () {
    final driver1 = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 1.0..lngDriver = 1.0;

    ManageDriversMethods.nearbyOnlineDriversList = [driver1];

    final updated = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 3.0..lngDriver = 4.0;
    ManageDriversMethods.updateOnlineNearbyDriversLocation(updated);

    expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, equals(3.0));
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.lngDriver, equals(4.0));
  });
}
