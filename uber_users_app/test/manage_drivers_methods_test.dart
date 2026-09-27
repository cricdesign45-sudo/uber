import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  setUp(() {
    ManageDriversMethods.clearDriversList();
  });

  test('addDriverToList adds driver and maintains index map', () {
    final driver1 = OnlineNearbyDrivers(uidDriver: 'd1', latDriver: 1.0, lngDriver: 1.0);
    ManageDriversMethods.addDriverToList(driver1);

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver, equals('d1'));
  });

  test('removeDriverFromList removes specified driver using O(1) swap-and-pop', () {
    final driver1 = OnlineNearbyDrivers(uidDriver: 'd1', latDriver: 1.0, lngDriver: 1.0);
    final driver2 = OnlineNearbyDrivers(uidDriver: 'd2', latDriver: 2.0, lngDriver: 2.0);
    final driver3 = OnlineNearbyDrivers(uidDriver: 'd3', latDriver: 3.0, lngDriver: 3.0);

    ManageDriversMethods.addDriverToList(driver1);
    ManageDriversMethods.addDriverToList(driver2);
    ManageDriversMethods.addDriverToList(driver3);

    // Remove middle driver 'd2'
    ManageDriversMethods.removeDriverFromList('d2');

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(2));
    final remainingIds = ManageDriversMethods.nearbyOnlineDriversList.map((d) => d.uidDriver).toList();
    expect(remainingIds, containsAll(['d1', 'd3']));

    // Verify location update still works in O(1) for remaining drivers
    final updatedD3 = OnlineNearbyDrivers(uidDriver: 'd3', latDriver: 9.0, lngDriver: 9.0);
    ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedD3);

    final d3InList = ManageDriversMethods.nearbyOnlineDriversList.firstWhere((d) => d.uidDriver == 'd3');
    expect(d3InList.latDriver, equals(9.0));
  });

  test('updateOnlineNearbyDriversLocation updates coordinates of existing driver in O(1)', () {
    final driver1 = OnlineNearbyDrivers(uidDriver: 'd1', latDriver: 1.0, lngDriver: 1.0);
    ManageDriversMethods.addDriverToList(driver1);

    final updatedInfo = OnlineNearbyDrivers(uidDriver: 'd1', latDriver: 5.0, lngDriver: 10.0);
    ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedInfo);

    expect(ManageDriversMethods.nearbyOnlineDriversList.first.latDriver, equals(5.0));
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.lngDriver, equals(10.0));
  });

  test('clearDriversList clears list and index maps', () {
    final driver1 = OnlineNearbyDrivers(uidDriver: 'd1', latDriver: 1.0, lngDriver: 1.0);
    ManageDriversMethods.addDriverToList(driver1);

    ManageDriversMethods.clearDriversList();
    expect(ManageDriversMethods.nearbyOnlineDriversList, isEmpty);

    // Re-adding after clear works correctly
    ManageDriversMethods.addDriverToList(driver1);
    expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
  });
}
