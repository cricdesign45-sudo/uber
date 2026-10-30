import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Search autocomplete debouncing prevents immediate/rapid API calls', () async {
    Timer? searchDebounce;
    int apiCallCount = 0;

    void onDestinationChanged(String query) {
      searchDebounce?.cancel();
      searchDebounce = Timer(const Duration(milliseconds: 300), () {
        apiCallCount++;
      });
    }

    // Simulate fast typing ("L", "La", "Lah", "Lahor", "Lahore")
    onDestinationChanged('L');
    onDestinationChanged('La');
    onDestinationChanged('Lah');
    onDestinationChanged('Lahor');
    onDestinationChanged('Lahore');

    // Instantly, no API calls should have been dispatched
    expect(apiCallCount, equals(0));

    // Wait past the debounce duration (e.g. 350ms)
    await Future.delayed(const Duration(milliseconds: 350));

    // Exactly 1 API request should have been dispatched
    expect(apiCallCount, equals(1));

    searchDebounce?.cancel();
  });
}
