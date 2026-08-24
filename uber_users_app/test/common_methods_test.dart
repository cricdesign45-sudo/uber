import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/common_methods.dart';

void main() {
  test('shortenAddress shortens comma separated address', () {
    expect(CommonMethods.shortenAddress("Main Street, Block A, City, Country"), "Main Street, Block A");
    expect(CommonMethods.shortenAddress("SingleAddress"), "SingleAddress");
  });

  test('formatTime formats minutes correctly', () {
    CommonMethods cMethods = CommonMethods();
    expect(cMethods.formatTime(125), "2 hours 5 mins");
    expect(cMethods.formatTime(45), "45 mins");
  });
}
