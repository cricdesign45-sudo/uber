import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/common_methods.dart';

void main() {
  group('CommonMethods Tests', () {
    test('shortenAddress returns street and city when available', () {
      final fullAddress = '123 Main St, Springfield, IL 62701, USA';
      final shortened = CommonMethods.shortenAddress(fullAddress);
      expect(shortened, equals('123 Main St, Springfield'));
    });

    test('shortenAddress returns full string if no comma present', () {
      final fullAddress = 'SingleAddressString';
      final shortened = CommonMethods.shortenAddress(fullAddress);
      expect(shortened, equals('SingleAddressString'));
    });

    test('formatTime converts minutes correctly', () {
      final methods = CommonMethods();
      expect(methods.formatTime(75), equals('1 hours 15 mins'));
      expect(methods.formatTime(45), equals('45 mins'));
      expect(methods.formatTime(0), equals('0 mins'));
    });
  });
}
