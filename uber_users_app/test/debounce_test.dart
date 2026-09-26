import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Debounce timer triggers callback after specified duration', () async {
    int callCount = 0;
    Timer? debounce;

    void onTextChanged(String text) {
      if (debounce?.isActive ?? false) debounce!.cancel();
      debounce = Timer(const Duration(milliseconds: 100), () {
        callCount++;
      });
    }

    // Simulate typing "Hello" quickly (5 keystrokes)
    onTextChanged('H');
    onTextChanged('He');
    onTextChanged('Hel');
    onTextChanged('Hell');
    onTextChanged('Hello');

    // Before timer fires
    expect(callCount, equals(0));

    // Wait for debounce duration
    await Future.delayed(const Duration(milliseconds: 150));

    // Callback should only have been called once after typing stopped
    expect(callCount, equals(1));

    debounce?.cancel();
  });
}
