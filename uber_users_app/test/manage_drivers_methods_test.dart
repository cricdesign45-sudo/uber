import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.clearAllDrivers();
  });

  test('ManageDriversMethods adds, updates location, and removes driver', () {
    OnlineNearbyDrivers driver = OnlineNearbyDrivers();
    driver.uidDriver = 'driver_123';
    driver.latDriver = 37.7749;
    driver.lngDriver = -122.4194;

    // Add driver
    ManageDriversMethods.addDriver(driver);
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, 37.7749);

    // Re-adding existing driver updates object and doesn't duplicate
    OnlineNearbyDrivers readdedDriver = OnlineNearbyDrivers();
    readdedDriver.uidDriver = 'driver_123';
    readdedDriver.latDriver = 37.7750;
    readdedDriver.lngDriver = -122.4195;
    ManageDriversMethods.addDriver(readdedDriver);
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, 37.7750);

    // Update driver location
    OnlineNearbyDrivers updatedInfo = OnlineNearbyDrivers();
    updatedInfo.uidDriver = 'driver_123';
    updatedInfo.latDriver = 37.7800;
    updatedInfo.lngDriver = -122.4200;

    ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedInfo);
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 1);
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, 37.7800);
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.lngDriver, -122.4200);

    // Remove driver
    ManageDriversMethods.removeDriverFromList('driver_123');
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, 0);
  });
}
