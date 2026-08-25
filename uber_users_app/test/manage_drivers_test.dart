import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/manage_drivers_methods.dart';
import 'package:uber_users_app/models/online_nearby_drivers.dart';

void main() {
  test('ManageDriversMethods Map index synchronization test', () {
    ManageDriversMethods.clearDriversList();

    OnlineNearbyDrivers driver1 = OnlineNearbyDrivers()
      ..uidDriver = "d1"
      ..latDriver = 10.0
      ..lngDriver = 20.0;

    OnlineNearbyDrivers driver2 = OnlineNearbyDrivers()
      ..uidDriver = "d2"
      ..latDriver = 30.0
      ..lngDriver = 40.0;

    ManageDriversMethods.addDriverToList(driver1);
    ManageDriversMethods.addDriverToList(driver2);

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(2));

    // Update location
    OnlineNearbyDrivers updatedDriver1 = OnlineNearbyDrivers()
      ..uidDriver = "d1"
      ..latDriver = 15.0
      ..lngDriver = 25.0;

    ManageDriversMethods.updateOnlineNearbyDriversLocation(updatedDriver1);

    expect(
        ManageDriversMethods.nearbyOnlineDriversList
            .firstWhere((d) => d.uidDriver == "d1")
            .latDriver,
        equals(15.0));
    expect(
        ManageDriversMethods.nearbyOnlineDriversList
            .firstWhere((d) => d.uidDriver == "d1")
            .lngDriver,
        equals(25.0));

    // Remove driver
    ManageDriversMethods.removeDriverFromList("d1");

    expect(ManageDriversMethods.nearbyOnlineDriversList.length, equals(1));
    expect(ManageDriversMethods.nearbyOnlineDriversList.first.uidDriver,
        equals("d2"));

    // Clear list
    ManageDriversMethods.clearDriversList();
    expect(ManageDriversMethods.nearbyOnlineDriversList.isEmpty, isTrue);
  });
}
