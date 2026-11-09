import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.clear();
  });

  test('addDriverToList adds new drivers and updates duplicates', () {
    final driver1 = OnlineNearbyDrivers()
      ..uidDriver = "driver_1"
      ..latDriver = 33.6844
      ..lngDriver = 73.0479;

    ManageDriversMethods.addDriverToList(driver1);

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList[0].uidDriver, "driver_1");
    expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, 33.6844);

    // Duplicate add updates coordinates without duplicating in list
    final driver1Updated = OnlineNearbyDrivers()
      ..uidDriver = "driver_1"
      ..latDriver = 33.7000
      ..lngDriver = 73.0600;

    ManageDriversMethods.addDriverToList(driver1Updated);
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, 33.7000);
  });

  test('updateOnlineNearbyDriversLocation updates coordinates in O(1)', () {
    final driver1 = OnlineNearbyDrivers()
      ..uidDriver = "driver_1"
      ..latDriver = 33.6844
      ..lngDriver = 73.0479;
    ManageDriversMethods.addDriverToList(driver1);

    final moveUpdate = OnlineNearbyDrivers()
      ..uidDriver = "driver_1"
      ..latDriver = 33.6900
      ..lngDriver = 73.0500;
    ManageDriversMethods.updateOnlineNearbyDriversLocation(moveUpdate);

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, 33.6900);
    expect(ManageDriversMethods.nearbyOnlineDriversList[0].lngDriver, 73.0500);
  });

  test('updateOnlineNearbyDriversLocation gracefully handles unknown driver', () {
    final unknownDriver = OnlineNearbyDrivers()
      ..uidDriver = "driver_unknown"
      ..latDriver = 34.0
      ..lngDriver = 74.0;

    ManageDriversMethods.updateOnlineNearbyDriversLocation(unknownDriver);
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList[0].uidDriver, "driver_unknown");
  });

  test('removeDriverFromList removes existing driver and handles missing driver', () {
    final driver1 = OnlineNearbyDrivers()
      ..uidDriver = "driver_1"
      ..latDriver = 33.0
      ..lngDriver = 73.0;
    final driver2 = OnlineNearbyDrivers()
      ..uidDriver = "driver_2"
      ..latDriver = 33.5
      ..lngDriver = 73.5;

    ManageDriversMethods.addDriverToList(driver1);
    ManageDriversMethods.addDriverToList(driver2);
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 2);

    ManageDriversMethods.removeDriverFromList("driver_1");
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList[0].uidDriver, "driver_2");

    // Removing a non-existent driver is a safe no-op
    ManageDriversMethods.removeDriverFromList("driver_nonexistent");
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
  });

  test('O(1) lookup benchmark across 1,000 drivers with 10,000 updates', () {
    // Populate 1,000 drivers
    for (int i = 0; i < 1000; i++) {
      final driver = OnlineNearbyDrivers()
        ..uidDriver = "driver_$i"
        ..latDriver = 30.0 + (i * 0.001)
        ..lngDriver = 70.0 + (i * 0.001);
      ManageDriversMethods.addDriverToList(driver);
    }
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1000);

    final stopwatch = Stopwatch()..start();
    // Simulate 10,000 high-frequency location tick updates
    for (int i = 0; i < 10000; i++) {
      final driverId = "driver_${i % 1000}";
      final update = OnlineNearbyDrivers()
        ..uidDriver = driverId
        ..latDriver = 31.0
        ..lngDriver = 71.0;
      ManageDriversMethods.updateOnlineNearbyDriversLocation(update);
    }
    stopwatch.stop();

    // 10,000 O(1) map lookups and property updates execute in only a few milliseconds
    expect(stopwatch.elapsedMilliseconds, lessThan(500));
  });
}
