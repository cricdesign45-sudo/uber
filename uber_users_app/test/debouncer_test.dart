import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Debouncer cancels pending execution if triggered rapidly', () async {
    int executionCount = 0;
    String lastQuery = '';

    Timer? timer;
    void debounceSearch(String query) {
      if (timer?.isActive ?? false) {
        timer!.cancel();
      }
      timer = Timer(const Duration(milliseconds: 400), () {
        executionCount++;
        lastQuery = query;
      });
    }

    // Simulate rapid typing: 'a', 'ab', 'abc' within 100ms intervals
    debounceSearch('a');
    await Future.delayed(const Duration(milliseconds: 100));
    expect(executionCount, equals(0));

    debounceSearch('ab');
    await Future.delayed(const Duration(milliseconds: 100));
    expect(executionCount, equals(0));

    debounceSearch('abc');
    await Future.delayed(const Duration(milliseconds: 100));
    expect(executionCount, equals(0));

    // Wait past the 400ms debounce threshold from the last keypress
    await Future.delayed(const Duration(milliseconds: 350));
    expect(executionCount, equals(1));
    expect(lastQuery, equals('abc'));

    timer?.cancel();
  });
}
