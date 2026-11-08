import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.clear();
  });

  test('adds, updates, and removes drivers correctly using addDriverToList', () {
    OnlineNearbyDrivers driver1 = OnlineNearbyDrivers();
    driver1.uidDriver = 'driver_1';
    driver1.latDriver = 31.5204;
    driver1.lngDriver = 74.3587;

    OnlineNearbyDrivers driver2 = OnlineNearbyDrivers();
    driver2.uidDriver = 'driver_2';
    driver2.latDriver = 31.5250;
    driver2.lngDriver = 74.3600;

    ManageDriversMethods.addDriverToList(driver1);
    ManageDriversMethods.addDriverToList(driver2);

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 2);

    // Update location of driver_1
    OnlineNearbyDrivers updatedDriver1 = OnlineNearbyDrivers();
    updatedDriver1.uidDriver = 'driver_1';
    updatedDriver1.latDriver = 31.5300;
    updatedDriver1.lngDriver = 74.3700;

    ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriver1);

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 2);
    final found = ManageDriversMethods.nearbyOnlineDriversList
        .firstWhere((d) => d.uidDriver == 'driver_1');
    expect(found.latDriver, 31.5300);
    expect(found.lngDriver, 74.3700);

    // Remove driver_2
    ManageDriversMethods.removeDriverFromList('driver_2');
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, 'driver_1');

    // Removing non-existent driver does nothing and doesn't crash
    ManageDriversMethods.removeDriverFromList('unknown_id');
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
  });

  test('backward compatibility: external list modifications sync properly', () {
    OnlineNearbyDrivers driver1 = OnlineNearbyDrivers();
    driver1.uidDriver = 'driver_legacy';
    driver1.latDriver = 10.0;
    driver1.lngDriver = 20.0;

    // Directly added to the list as legacy code might do
    ManageDriversMethods.nearbyOnlineDriversList.add(driver1);
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);

    // Update should sync and find the driver
    OnlineNearbyDrivers updatedDriver = OnlineNearbyDrivers();
    updatedDriver.uidDriver = 'driver_legacy';
    updatedDriver.latDriver = 15.0;
    updatedDriver.lngDriver = 25.0;

    ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriver);
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, 15.0);

    // Remove should also work
    ManageDriversMethods.removeDriverFromList('driver_legacy');
    expect(ManageDriversMethods.nearbyOnlineDriversList.isEmpty, true);
  });
}
