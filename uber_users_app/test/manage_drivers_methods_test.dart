import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.nearbyOnlineDriversList.clear();
  });

  tearDown(() {
    ManageDriversMethods.nearbyOnlineDriversList.clear();
  });

  test('ManageDriversMethods can add, update location, and remove driver', () {
    var driver1 = OnlineNearbyDrivers(
      uidDriver: "d1",
      latDriver: 37.7749,
      lngDriver: -122.4194,
    );
    var driver2 = OnlineNearbyDrivers(
      uidDriver: "d2",
      latDriver: 37.7750,
      lngDriver: -122.4195,
    );

    ManageDriversMethods.addDriverToList(driver1);
    ManageDriversMethods.addDriverToList(driver2);

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 2);

    // Update location of driver 2
    var updatedDriver2 = OnlineNearbyDrivers(
      uidDriver: "d2",
      latDriver: 37.7800,
      lngDriver: -122.4200,
    );
    ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriver2);

    expect(ManageDriversMethods.nearbyOnlineDriversList[1].latDriver, 37.7800);
    expect(ManageDriversMethods.nearbyOnlineDriversList[1].lngDriver, -122.4200);

    // Re-adding same driver updates in-place
    var updatedDriver2Again = OnlineNearbyDrivers(
      uidDriver: "d2",
      latDriver: 37.7850,
      lngDriver: -122.4250,
    );
    ManageDriversMethods.addDriverToList(updatedDriver2Again);
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 2);
    expect(ManageDriversMethods.nearbyOnlineDriversList[1].latDriver, 37.7850);

    // Remove driver 1
    ManageDriversMethods.removeDriverFromList("d1");
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList[0].uidDriver, "d2");

    // Remove non-existent driver gracefully
    ManageDriversMethods.removeDriverFromList("non_existent");
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
  });

  test('ManageDriversMethods handles external list modifications safely', () {
    // Direct list manipulation fallback
    var driver1 = OnlineNearbyDrivers(uidDriver: "ext1", latDriver: 10, lngDriver: 10);
    var driver2 = OnlineNearbyDrivers(uidDriver: "ext2", latDriver: 20, lngDriver: 20);

    ManageDriversMethods.nearbyOnlineDriversList.add(driver1);
    ManageDriversMethods.nearbyOnlineDriversList.add(driver2);

    // Update driver 1 location
    var updateExt1 = OnlineNearbyDrivers(uidDriver: "ext1", latDriver: 15, lngDriver: 15);
    ManageDriversMethods.updateOnlineNearbyDriversLocation(updateExt1);
    expect(ManageDriversMethods.nearbyOnlineDriversList[0].latDriver, 15);

    // Remove driver 2
    ManageDriversMethods.removeDriverFromList("ext2");
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList[0].uidDriver, "ext1");
  });

  test('Benchmark: location updates with 500 drivers', () {
    const int driverCount = 500;
    for (int i = 0; i < driverCount; i++) {
      ManageDriversMethods.addDriverToList(
        OnlineNearbyDrivers(
          uidDriver: "driver_$i",
          latDriver: 30.0 + (i * 0.001),
          lngDriver: 70.0 + (i * 0.001),
        ),
      );
    }

    final stopwatch = Stopwatch()..start();
    // Simulate 5000 location updates across the drivers
    for (int i = 0; i < 5000; i++) {
      int driverIndex = i % driverCount;
      ManageDriversMethods.updateOnlineNearbyDriversLocation(
        OnlineNearbyDrivers(
          uidDriver: "driver_$driverIndex",
          latDriver: 31.0 + (i * 0.0001),
          lngDriver: 71.0 + (i * 0.0001),
        ),
      );
    }
    stopwatch.stop();
    print('Time taken for 5000 location updates across 500 drivers: ${stopwatch.elapsedMilliseconds}ms');
    expect(stopwatch.elapsedMilliseconds, lessThan(1000));
  });
}
