import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Destination Search Debounce Tests', () {
    test('debounces rapid keystrokes so only the last query is executed', () async {
      int apiCallCount = 0;
      String? lastSearchedQuery;

      Timer? searchDebounce;

      void onSearchTextChanged(String value) {
        searchDebounce?.cancel();
        searchDebounce = Timer(const Duration(milliseconds: 400), () {
          apiCallCount++;
          lastSearchedQuery = value;
        });
      }

      // Simulate typing "Lahore" rapidly within 100ms intervals
      final keystrokes = ['L', 'La', 'Lah', 'Laho', 'Lahor', 'Lahore'];
      for (final text in keystrokes) {
        onSearchTextChanged(text);
        await Future.delayed(const Duration(milliseconds: 50));
      }

      // At this point, 250ms have passed since the first keystroke, but only 50ms since the last.
      // No search calls should have fired yet.
      expect(apiCallCount, 0);

      // Wait for the debounce duration (400ms) to elapse after the last keystroke.
      await Future.delayed(const Duration(milliseconds: 450));

      // Exactly one search call should have fired with the final string.
      expect(apiCallCount, 1);
      expect(lastSearchedQuery, 'Lahore');

      searchDebounce?.cancel();
    });

    test('timer cancellation on widget disposal prevents execution', () async {
      int apiCallCount = 0;
      Timer? searchDebounce;

      void onSearchTextChanged(String value) {
        searchDebounce?.cancel();
        searchDebounce = Timer(const Duration(milliseconds: 400), () {
          apiCallCount++;
        });
      }

      onSearchTextChanged('Islamabad');

      // Simulate widget disposal before timer expires
      searchDebounce?.cancel();

      await Future.delayed(const Duration(milliseconds: 450));

      expect(apiCallCount, 0);
    });
  });
}
