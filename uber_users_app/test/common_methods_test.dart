import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/common_methods.dart';

void main() {
  group('CommonMethods Unit Tests', () {
    test('shortenAddress extracts first two parts of comma separated address', () {
      final result = CommonMethods.shortenAddress("Main Street 123, Downtown, City, Country");
      expect(result, equals("Main Street 123, Downtown"));
    });

    test('shortenAddress returns full string if no comma', () {
      final result = CommonMethods.shortenAddress("SingleAddress");
      expect(result, equals("SingleAddress"));
    });

    test('formatTime formats total minutes into hours and mins', () {
      final commonMethods = CommonMethods();
      expect(commonMethods.formatTime(125), equals("2 hours 5 mins"));
      expect(commonMethods.formatTime(45), equals("45 mins"));
    });
  });
}
