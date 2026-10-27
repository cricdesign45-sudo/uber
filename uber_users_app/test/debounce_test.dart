import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Debounce timer triggers callback only once after delay', () async {
    int callCount = 0;
    Timer? debounceTimer;

    void onInputChanged(String value) {
      if (debounceTimer?.isActive ?? false) {
        debounceTimer!.cancel();
      }
      debounceTimer = Timer(const Duration(milliseconds: 100), () {
        callCount++;
      });
    }

    // Simulate rapid keystrokes ('L', 'La', 'Lah', 'Laho', 'Lahor', 'Lahore')
    onInputChanged('L');
    onInputChanged('La');
    onInputChanged('Lah');
    onInputChanged('Laho');
    onInputChanged('Lahor');
    onInputChanged('Lahore');

    // Instantly, callCount should be 0 because of debounce
    expect(callCount, equals(0));

    // Wait for debounce timer to complete
    await Future.delayed(const Duration(milliseconds: 150));

    // After delay, search should have executed exactly once
    expect(callCount, equals(1));

    debounceTimer?.cancel();
  });
}
