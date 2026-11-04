import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Search Place Debounce Logic', () {
    test('rapid keystrokes should only trigger search once after debounce delay', () async {
      Timer? debounce;
      int searchInvocationCount = 0;
      String? lastSearchedQuery;

      void onSearchChanged(String value) {
        if (debounce?.isActive ?? false) debounce!.cancel();
        debounce = Timer(const Duration(milliseconds: 400), () {
          searchInvocationCount++;
          lastSearchedQuery = value;
        });
      }

      // Simulate rapid keystrokes: "L", "La", "Lah", "Laho", "Lahore"
      onSearchChanged("L");
      await Future.delayed(const Duration(milliseconds: 50));
      onSearchChanged("La");
      await Future.delayed(const Duration(milliseconds: 50));
      onSearchChanged("Lah");
      await Future.delayed(const Duration(milliseconds: 50));
      onSearchChanged("Laho");
      await Future.delayed(const Duration(milliseconds: 50));
      onSearchChanged("Lahore");

      // Before 400ms duration has elapsed, zero searches should have triggered
      expect(searchInvocationCount, 0);

      // Wait for debounce timer to fire
      await Future.delayed(const Duration(milliseconds: 450));

      // Exactly one search invocation should have fired with the final value
      expect(searchInvocationCount, 1);
      expect(lastSearchedQuery, "Lahore");

      debounce?.cancel();
    });

    test('cancelled debounce timer does not fire callback', () async {
      Timer? debounce;
      bool wasExecuted = false;

      debounce = Timer(const Duration(milliseconds: 400), () {
        wasExecuted = true;
      });

      // Cancel immediately (similar to widget dispose())
      debounce.cancel();

      await Future.delayed(const Duration(milliseconds: 450));
      expect(wasExecuted, isFalse);
    });
  });
}
