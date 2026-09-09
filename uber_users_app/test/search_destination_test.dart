import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Debounce timer properly delays invocation and cancels previous timers', () async {
    int calls = 0;
    Timer? debounce;

    void triggerSearch(String text) {
      if (debounce?.isActive ?? false) {
        debounce!.cancel();
      }
      debounce = Timer(const Duration(milliseconds: 100), () {
        calls++;
      });
    }

    // Simulate typing rapidly: 'N', 'Ne', 'New', 'New '
    triggerSearch('N');
    triggerSearch('Ne');
    triggerSearch('New');
    triggerSearch('New ');

    expect(calls, equals(0));

    // Wait for timer to fire
    await Future.delayed(const Duration(milliseconds: 150));

    // Only 1 API request should have been made instead of 4
    expect(calls, equals(1));
  });
}
