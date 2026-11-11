import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/common_methods.dart';
import 'package:uber_users_app/models/direction_details.dart';

void main() {
  group('CommonMethods Fare & Time Optimization Tests', () {
    test('calculateFareAndTimeForVehicle for Car returns exact car fare and time', () {
      final result = CommonMethods.calculateFareAndTimeForVehicle(
        vehicleType: 'Car',
        actualFareAmountCar: 500.0,
        estimatedTimeCar: '30 mins',
      );

      expect(result.fare, 500.0);
      expect(result.estimatedTime, '30 mins');
    });

    test('calculateFareAndTimeForVehicle for Auto scales fare by 0.8 and duration by 1.2', () {
      final result = CommonMethods.calculateFareAndTimeForVehicle(
        vehicleType: 'Auto',
        actualFareAmountCar: 500.0,
        estimatedTimeCar: '30 mins',
      );

      expect(result.fare, 400.0); // 500 * 0.8
      expect(result.estimatedTime, '36 mins'); // 30 * 1.2 = 36 mins
    });

    test('calculateFareAndTimeForVehicle for Bike scales fare by 0.4 and duration by 0.8', () {
      final result = CommonMethods.calculateFareAndTimeForVehicle(
        vehicleType: 'Bike',
        actualFareAmountCar: 500.0,
        estimatedTimeCar: '30 mins',
      );

      expect(result.fare, 200.0); // 500 * 0.4
      expect(result.estimatedTime, '24 mins'); // 30 * 0.8 = 24 mins
    });

    test('calculateFareAndTimeForVehicle handles hours format correctly', () {
      final result = CommonMethods.calculateFareAndTimeForVehicle(
        vehicleType: 'Auto',
        actualFareAmountCar: 1000.0,
        estimatedTimeCar: '1 hours 30 mins', // 90 mins total
      );

      expect(result.fare, 800.0);
      // 90 * 1.2 = 108 mins -> 1 hours 48 mins
      expect(result.estimatedTime, '1 hours 48 mins');
    });

    test('calculateFareAmountInPKR enforces minimum fare and computes correctly', () {
      final cMethods = CommonMethods();
      final directionDetails = DirectionDetails();
      // Distance 5 km = 5000 m; Duration 10 mins = 600 seconds
      directionDetails.distanceValueDigit = 5000;
      directionDetails.durationValueDigit = 600;

      // Base fare: 150, Distance: 5*20 = 100, Duration: 10*15 = 150, Booking: 50
      // Total before surge: 150 + 100 + 150 + 50 = 450
      final fareString = cMethods.calculateFareAmountInPKR(directionDetails);
      expect(double.parse(fareString), 450.0);

      // Test minimum fare threshold
      final shortTrip = DirectionDetails();
      shortTrip.distanceValueDigit = 0;
      shortTrip.durationValueDigit = 0;
      // Total before surge: 150 + 0 + 0 + 50 = 200, min fare is 200
      final minFareString = cMethods.calculateFareAmountInPKR(shortTrip);
      expect(double.parse(minFareString), 200.0);
    });
  });
}
