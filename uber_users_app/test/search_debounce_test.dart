import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

// Standalone test helper verifying the debounce behavior used in SearchDestinationPlace
class TestSearchDebouncer {
  Timer? _debounceTimer;
  final Duration delay;

  TestSearchDebouncer({this.delay = const Duration(milliseconds: 400)});

  void onQueryChanged(String value, void Function(String) onSearch, void Function() onClear) {
    _debounceTimer?.cancel();
    if (value.trim().length <= 1) {
      onClear();
      return;
    }
    _debounceTimer = Timer(delay, () {
      onSearch(value.trim());
    });
  }

  void dispose() {
    _debounceTimer?.cancel();
  }
}

void main() {
  group('Search Debouncer Tests', () {
    test('debounces rapid keystrokes and only fires the last query', () async {
      final debouncer = TestSearchDebouncer(delay: const Duration(milliseconds: 50));
      final List<String> dispatchedQueries = [];
      int clearCount = 0;

      void onSearch(String q) => dispatchedQueries.add(q);
      void onClear() => clearCount++;

      // Simulate typing 'Lahore' rapidly
      debouncer.onQueryChanged('L', onSearch, onClear);
      debouncer.onQueryChanged('La', onSearch, onClear);
      debouncer.onQueryChanged('Lah', onSearch, onClear);
      debouncer.onQueryChanged('Laho', onSearch, onClear);
      debouncer.onQueryChanged('Lahor', onSearch, onClear);
      debouncer.onQueryChanged('Lahore', onSearch, onClear);

      // Prior to delay completing, nothing should be dispatched
      expect(dispatchedQueries, isEmpty);
      // 'L' has length <= 1, so onClear was called once
      expect(clearCount, 1);

      // Wait for debounce period to pass
      await Future.delayed(const Duration(milliseconds: 80));

      // Only the final query 'Lahore' should have been dispatched once
      expect(dispatchedQueries, ['Lahore']);
      expect(dispatchedQueries.length, 1);

      debouncer.dispose();
    });

    test('clears results when search input is empty or 1 character', () async {
      final debouncer = TestSearchDebouncer(delay: const Duration(milliseconds: 50));
      final List<String> dispatchedQueries = [];
      int clearCount = 0;

      debouncer.onQueryChanged('', (q) => dispatchedQueries.add(q), () => clearCount++);
      debouncer.onQueryChanged('a', (q) => dispatchedQueries.add(q), () => clearCount++);

      await Future.delayed(const Duration(milliseconds: 80));

      expect(dispatchedQueries, isEmpty);
      expect(clearCount, 2);

      debouncer.dispose();
    });
  });
}
