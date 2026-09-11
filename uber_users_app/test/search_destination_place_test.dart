import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Debounce timer properly delays execution', () async {
    Timer? searchDebounceTimer;
    int executionCount = 0;

    void onDestinationChanged(String value) {
      if (searchDebounceTimer?.isActive ?? false) {
        searchDebounceTimer!.cancel();
      }

      if (value.trim().length <= 1) {
        return;
      }

      searchDebounceTimer = Timer(const Duration(milliseconds: 100), () {
        executionCount++;
      });
    }

    // Simulate typing "Lahore" rapidly character by character
    onDestinationChanged("L");
    onDestinationChanged("La");
    onDestinationChanged("Lah");
    onDestinationChanged("Laho");
    onDestinationChanged("Lahor");
    onDestinationChanged("Lahore");

    // Execution should not have happened yet
    expect(executionCount, equals(0));

    // Wait for debounce timer to fire
    await Future.delayed(const Duration(milliseconds: 150));

    // Should only have executed once despite 6 character inputs
    expect(executionCount, equals(1));
  });
}
