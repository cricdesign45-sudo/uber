import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Debounce timer triggers callback only after delay', () async {
    int callCount = 0;
    Timer? debounceTimer;

    void onTextChanged(String text) {
      debounceTimer?.cancel();
      if (text.trim().length <= 1) {
        callCount = 0;
        return;
      }
      debounceTimer = Timer(const Duration(milliseconds: 100), () {
        callCount++;
      });
    }

    // Simulate typing "L", "La", "Lah", "Laho", "Lahor", "Lahore" rapidly
    onTextChanged("L");
    onTextChanged("La");
    onTextChanged("Lah");
    onTextChanged("Laho");
    onTextChanged("Lahor");
    onTextChanged("Lahore");

    // Immediately after typing, callCount should still be 0
    expect(callCount, equals(0));

    // Wait for debounce duration
    await Future.delayed(const Duration(milliseconds: 150));

    // Only 1 API request should have been triggered
    expect(callCount, equals(1));
  });
}
