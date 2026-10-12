import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Debounce timer triggers callback after delay and cancels prior timers', () async {
    int callCount = 0;
    String lastQuery = '';
    Timer? debounceTimer;

    void searchDebounced(String query) {
      if (debounceTimer?.isActive ?? false) {
        debounceTimer!.cancel();
      }
      debounceTimer = Timer(const Duration(milliseconds: 100), () {
        callCount++;
        lastQuery = query;
      });
    }

    // Simulate typing "Lahore" rapidly
    searchDebounced("L");
    searchDebounced("La");
    searchDebounced("Lah");
    searchDebounced("Laho");
    searchDebounced("Lahor");
    searchDebounced("Lahore");

    // Before timer fires
    expect(callCount, equals(0));

    // Wait for debounce duration
    await Future.delayed(const Duration(milliseconds: 150));

    // Only 1 final call should have been executed
    expect(callCount, equals(1));
    expect(lastQuery, equals("Lahore"));
  });
}
