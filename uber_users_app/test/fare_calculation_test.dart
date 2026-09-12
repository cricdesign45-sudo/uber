import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/common_methods.dart';
import 'package:uber_users_app/models/direction_details.dart';

void main() {
  group('Fare and Time Calculations', () {
    final commonMethods = CommonMethods();

    test('formatTime formats total minutes correctly', () {
      expect(commonMethods.formatTime(125), '2 hours 5 mins');
      expect(commonMethods.formatTime(45), '45 mins');
      expect(commonMethods.formatTime(60), '1 hours 0 mins');
    });

    test('calculateFareAmountInPKR returns correct fare string', () {
      final directionDetails = DirectionDetails()
        ..distanceValueDigit = 10000 // 10 km -> 10 * 20 = 200 PKR
        ..durationValueDigit = 1200; // 20 mins -> 20 * 15 = 300 PKR
      // Base: 150 + 200 + 300 + Booking 50 = 700 PKR

      final fare = commonMethods.calculateFareAmountInPKR(directionDetails);
      expect(fare, '700.00');
    });
  });
}
