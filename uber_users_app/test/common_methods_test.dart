import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/common_methods.dart';

void main() {
  group('CommonMethods Unit Tests', () {
    test('shortenAddress shortens full address correctly', () {
      String fullAddress = "123 Main Street, Model Town, Lahore, Punjab, Pakistan";
      String shortened = CommonMethods.shortenAddress(fullAddress);
      expect(shortened, equals("123 Main Street, Model Town"));
    });

    test('formatTime formats total minutes correctly', () {
      CommonMethods cMethods = CommonMethods();
      expect(cMethods.formatTime(45), equals("45 mins"));
      expect(cMethods.formatTime(125), equals("2 hours 5 mins"));
    });
  });
}
