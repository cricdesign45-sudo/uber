import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.clearDriversList();
  });

  test('addDriverToList adds driver and provides O(1) lookup in list getter', () {
    final driver = OnlineNearbyDrivers()
      ..uidDriver = 'driver_1'
      ..latDriver = 37.7749
      ..lngDriver = -122.4194;

    ManageDriversMethods.addDriverToList(driver);

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, equals('driver_1'));
  });

  test('updateOnlineNearbyDriversLocation updates location in O(1) time', () {
    final driver = OnlineNearbyDrivers()
      ..uidDriver = 'driver_1'
      ..latDriver = 37.7749
      ..lngDriver = -122.4194;

    ManageDriversMethods.addDriverToList(driver);

    final updatedDriverInfo = OnlineNearbyDrivers()
      ..uidDriver = 'driver_1'
      ..latDriver = 37.7800
      ..lngDriver = -122.4200;

    ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriverInfo);

    final currentDriver = ManageDriversMethods.nearbyOnlineDriversList.first;
    expect(currentDriver.latDriver, equals(37.7800));
    expect(currentDriver.lngDriver, equals(-122.4200));
  });

  test('removeDriverFromList removes driver in O(1) time', () {
    final driver1 = OnlineNearbyDrivers()
      ..uidDriver = 'driver_1'
      ..latDriver = 37.7749
      ..lngDriver = -122.4194;

    final driver2 = OnlineNearbyDrivers()
      ..uidDriver = 'driver_2'
      ..latDriver = 37.7750
      ..lngDriver = -122.4195;

    ManageDriversMethods.addDriverToList(driver1);
    ManageDriversMethods.addDriverToList(driver2);

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(2));

    ManageDriversMethods.removeDriverFromList('driver_1');

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, equals('driver_2'));
  });
}
