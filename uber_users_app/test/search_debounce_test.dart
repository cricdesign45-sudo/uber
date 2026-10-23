import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Search Debounce Tests', () {
    test('Debouncer delays execution and cancels previous timer on rapid inputs', () async {
      int callCount = 0;
      String lastQuery = '';
      Timer? searchDebounce;

      void onSearchChanged(String query) {
        if (searchDebounce?.isActive ?? false) {
          searchDebounce!.cancel();
        }
        searchDebounce = Timer(const Duration(milliseconds: 50), () {
          callCount++;
          lastQuery = query;
        });
      }

      // Rapid user keystrokes for "Lahore"
      onSearchChanged('L');
      await Future.delayed(const Duration(milliseconds: 10));
      onSearchChanged('La');
      await Future.delayed(const Duration(milliseconds: 10));
      onSearchChanged('Lah');
      await Future.delayed(const Duration(milliseconds: 10));
      onSearchChanged('Laho');
      await Future.delayed(const Duration(milliseconds: 10));
      onSearchChanged('Lahor');
      await Future.delayed(const Duration(milliseconds: 10));
      onSearchChanged('Lahore');

      // During rapid typing, no call should have been triggered yet
      expect(callCount, equals(0));

      // Wait past the debounce threshold after the last keystroke
      await Future.delayed(const Duration(milliseconds: 70));

      // Only 1 call should be made with the final query
      expect(callCount, equals(1));
      expect(lastQuery, equals('Lahore'));
    });
  });
}
