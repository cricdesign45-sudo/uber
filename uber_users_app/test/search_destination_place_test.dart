import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Debounce timer cancels previous calls and executes only the last call after delay', () async {
    int executionCount = 0;
    String lastSearchTerm = '';
    Timer? searchDebounceTimer;

    void onTextChanged(String value) {
      searchDebounceTimer?.cancel();
      if (value.trim().length <= 1) return;

      searchDebounceTimer = Timer(const Duration(milliseconds: 300), () {
        executionCount++;
        lastSearchTerm = value;
      });
    }

    // Simulate fast typing "Islamabad" (9 keystrokes)
    onTextChanged('I');
    onTextChanged('Is');
    onTextChanged('Isl');
    onTextChanged('Isla');
    onTextChanged('Islam');
    onTextChanged('Islama');
    onTextChanged('Islamab');
    onTextChanged('Islamaba');
    onTextChanged('Islamabad');

    // Before 300ms, no API execution should have occurred
    expect(executionCount, equals(0));

    // Wait 350ms to allow debounce timer to fire
    await Future.delayed(const Duration(milliseconds: 350));

    // Exactly 1 execution should occur for the last search term
    expect(executionCount, equals(1));
    expect(lastSearchTerm, equals('Islamabad'));
  });
}
