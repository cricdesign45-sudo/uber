import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.nearbyOnlineDriversList.clear();
    ManageDriversMethods.nearbyOnlineDriversMap.clear();
  });

  test('addDriver adds to both list and map', () {
    OnlineNearbyDrivers d1 = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 1.0..lngDriver = 2.0;
    ManageDriversMethods.addDriver(d1);

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversMap.containsKey('d1'), true);
  });

  test('addDriver with existing ID updates existing instance without duplicating list items', () {
    OnlineNearbyDrivers d1 = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 1.0..lngDriver = 2.0;
    ManageDriversMethods.addDriver(d1);

    OnlineNearbyDrivers d1New = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 3.0..lngDriver = 4.0;
    ManageDriversMethods.addDriver(d1New);

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversMap.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, 3.0);
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.lngDriver, 4.0);

    // Verify removeDriverFromList works cleanly after re-adding
    ManageDriversMethods.removeDriverFromList('d1');
    expect(ManageDriversMethods.nearbyOnlineDriversList.isEmpty, true);
    expect(ManageDriversMethods.nearbyOnlineDriversMap.isEmpty, true);
  });

  test('removeDriverFromList removes correctly from both list and map', () {
    OnlineNearbyDrivers d1 = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 1.0..lngDriver = 2.0;
    OnlineNearbyDrivers d2 = OnlineNearbyDrivers()..uidDriver = 'd2'..latDriver = 3.0..lngDriver = 4.0;

    ManageDriversMethods.addDriver(d1);
    ManageDriversMethods.addDriver(d2);

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 2);
    expect(ManageDriversMethods.nearbyOnlineDriversMap.length, 2);

    ManageDriversMethods.removeDriverFromList('d1');

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversMap.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, 'd2');
    expect(ManageDriversMethods.nearbyOnlineDriversMap.containsKey('d1'), false);
  });

  test('updateOnlineNearbyDriversLocation updates correctly via map lookup', () {
    OnlineNearbyDrivers d1 = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 1.0..lngDriver = 2.0;
    ManageDriversMethods.addDriver(d1);

    OnlineNearbyDrivers d1Update = OnlineNearbyDrivers()..uidDriver = 'd1'..latDriver = 5.0..lngDriver = 6.0;
    ManageDriversMethods.updateOnlineNearbyDriversLocation(d1Update);

    expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, 5.0);
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.lngDriver, 6.0);
  });
}
