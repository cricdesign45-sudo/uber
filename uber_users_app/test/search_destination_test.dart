import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Search input debouncer delays function execution and cancels pending calls', () async {
    int searchCallCount = 0;
    String lastQuery = '';
    Timer? searchDebounceTimer;

    void onSearchChanged(String query) {
      if (searchDebounceTimer?.isActive ?? false) {
        searchDebounceTimer!.cancel();
      }
      searchDebounceTimer = Timer(const Duration(milliseconds: 400), () {
        searchCallCount++;
        lastQuery = query;
      });
    }

    // Simulate typing rapidly: 'N', 'Ne', 'New', 'New ', 'New Y', 'New Yo', 'New Yor', 'New York'
    onSearchChanged('N');
    onSearchChanged('Ne');
    onSearchChanged('New');
    onSearchChanged('New ');
    onSearchChanged('New Y');
    onSearchChanged('New Yo');
    onSearchChanged('New Yor');
    onSearchChanged('New York');

    // Right after typing rapidly, no search should have executed yet
    expect(searchCallCount, equals(0));

    // Wait for debounce timer (400ms)
    await Future.delayed(const Duration(milliseconds: 450));

    // Only 1 search should have executed for the final query 'New York'
    expect(searchCallCount, equals(1));
    expect(lastQuery, equals('New York'));

    searchDebounceTimer?.cancel();
  });
}
