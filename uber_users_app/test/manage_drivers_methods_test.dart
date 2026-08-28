import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.clearDriversList();
  });

  test('addDriverToList and removeDriverFromList manage driver state correctly', () {
    final d1 = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 1.0..lngDriver = 1.0;
    final d2 = OnlineNearbyDrivers()..uidDriver = 'd2'..latDriver = 2.0..lngDriver = 2.0;
    ManageDriversMethods.addDriverToList(d1);
    ManageDriversMethods.addDriverToList(d2);

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 2);

    ManageDriversMethods.removeDriverFromList('d1');

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, 'd2');
  });

  test('updateOnlineNearbyDriversLocation updates location for driver in O(1)', () {
    final d1 = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 1.0..lngDriver = 1.0;
    ManageDriversMethods.addDriverToList(d1);

    final updated = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 3.0..lngDriver = 4.0;
    ManageDriversMethods.updateOnlineNearbyDriversLocation(updated);

    expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, 3.0);
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.lngDriver, 4.0);
  });
}
