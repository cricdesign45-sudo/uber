import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Search debounce delays execution and cancels previous timer', () async {
    int executionCount = 0;
    String lastQuery = '';
    Timer? searchDebounce;

    void onSearchChanged(String query) {
      if (searchDebounce?.isActive ?? false) searchDebounce!.cancel();
      searchDebounce = Timer(const Duration(milliseconds: 100), () {
        executionCount++;
        lastQuery = query;
      });
    }

    // Rapidly simulate user typing: "N", "Ne", "New", "New ", "New Y", "New York"
    onSearchChanged("N");
    onSearchChanged("Ne");
    onSearchChanged("New");
    onSearchChanged("New ");
    onSearchChanged("New Y");
    onSearchChanged("New York");

    // Immediately after typing, timer should not have executed yet
    expect(executionCount, equals(0));

    // Wait for debounce duration
    await Future.delayed(const Duration(milliseconds: 150));

    // Only the final search query should have executed exactly once
    expect(executionCount, equals(1));
    expect(lastQuery, equals("New York"));

    searchDebounce?.cancel();
  });
}
