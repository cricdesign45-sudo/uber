import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/common_methods.dart';

void main() {
  group('CommonMethods Tests', () {
    final commonMethods = CommonMethods();

    test('shortenAddress shortens long address to street and city', () {
      const fullAddress = '123 Main St, Springfield, IL 62701, USA';
      final result = CommonMethods.shortenAddress(fullAddress);
      expect(result, equals('123 Main St, Springfield'));
    });

    test('shortenAddress returns unchanged if less than two comma-separated parts', () {
      const shortAddress = 'Springfield';
      final result = CommonMethods.shortenAddress(shortAddress);
      expect(result, equals('Springfield'));
    });

    test('formatTime formats total minutes into hours and mins', () {
      expect(commonMethods.formatTime(125), equals('2 hours 5 mins'));
      expect(commonMethods.formatTime(45), equals('45 mins'));
      expect(commonMethods.formatTime(60), equals('1 hours 0 mins'));
    });
  });
}
