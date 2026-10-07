import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Debounce logic prevents rapid successive executions', () async {
    int executionCount = 0;
    Timer? debounceTimer;

    void onSearchTextChanged(String value) {
      if (debounceTimer?.isActive ?? false) {
        debounceTimer!.cancel();
      }
      debounceTimer = Timer(const Duration(milliseconds: 100), () {
        executionCount++;
      });
    }

    // Simulate fast typing
    onSearchTextChanged('L');
    onSearchTextChanged('La');
    onSearchTextChanged('Lah');
    onSearchTextChanged('Laho');
    onSearchTextChanged('Lahor');
    onSearchTextChanged('Lahore');

    // Before timer fires
    expect(executionCount, 0);

    // Wait for debounce duration
    await Future.delayed(const Duration(milliseconds: 150));

    // Only 1 execution occurred despite 6 keypresses
    expect(executionCount, 1);
  });
}
