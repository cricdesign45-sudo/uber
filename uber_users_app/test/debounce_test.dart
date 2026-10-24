import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Debounce timer cancels rapid successive calls', () async {
    int executionCount = 0;
    Timer? searchDebounce;

    void debouncedSearch(String query) {
      searchDebounce?.cancel();
      searchDebounce = Timer(const Duration(milliseconds: 100), () {
        executionCount++;
      });
    }

    // Rapid successive queries (e.g. typing "L", "La", "Lah", "Laho", "Lahor", "Lahore")
    debouncedSearch('L');
    debouncedSearch('La');
    debouncedSearch('Lah');
    debouncedSearch('Laho');
    debouncedSearch('Lahor');
    debouncedSearch('Lahore');

    expect(executionCount, equals(0));

    // Wait for the debounce duration
    await Future.delayed(const Duration(milliseconds: 150));

    // Only the last query should have executed
    expect(executionCount, equals(1));

    searchDebounce?.cancel();
  });
}
