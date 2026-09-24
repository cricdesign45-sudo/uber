import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/common_methods.dart';

void main() {
  group('CommonMethods.shortenAddress', () {
    test('shortens address with multiple commas', () {
      const fullAddress = '123 Main St, Springfield, IL 62701, USA';
      final result = CommonMethods.shortenAddress(fullAddress);
      expect(result, equals('123 Main St, Springfield'));
    });

    test('shortens address with exactly two parts', () {
      const fullAddress = '123 Main St, Springfield';
      final result = CommonMethods.shortenAddress(fullAddress);
      expect(result, equals('123 Main St, Springfield'));
    });

    test('returns original address when no comma exists', () {
      const fullAddress = '123 Main St Springfield';
      final result = CommonMethods.shortenAddress(fullAddress);
      expect(result, equals('123 Main St Springfield'));
    });

    test('handles leading and trailing whitespace around comma parts', () {
      const fullAddress = '  456 Elm St  ,   Metropolis  , NY';
      final result = CommonMethods.shortenAddress(fullAddress);
      expect(result, equals('456 Elm St, Metropolis'));
    });
  });
}
