import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Search Debounce Logic', () {
    testWidgets('rapid keystrokes within debounce duration only trigger one final search', (WidgetTester tester) async {
      Timer? debounceTimer;
      final List<String> searchInvocations = [];

      void onSearchTextChanged(String value) {
        debounceTimer?.cancel();
        if (value.trim().length <= 1) {
          return;
        }
        debounceTimer = Timer(const Duration(milliseconds: 500), () {
          searchInvocations.add(value.trim());
        });
      }

      // Simulate rapid typing: "La", "Lah", "Laho", "Lahore" typed within 100ms intervals
      onSearchTextChanged('La');
      await tester.pump(const Duration(milliseconds: 100));

      onSearchTextChanged('Lah');
      await tester.pump(const Duration(milliseconds: 100));

      onSearchTextChanged('Laho');
      await tester.pump(const Duration(milliseconds: 100));

      onSearchTextChanged('Lahore');
      // Before 500ms elapses, no search should have fired yet
      expect(searchInvocations, isEmpty);

      // Elapse 400ms (still only 400ms since last keystroke)
      await tester.pump(const Duration(milliseconds: 400));
      expect(searchInvocations, isEmpty);

      // Elapse remaining 100ms (total 500ms elapsed since last keystroke)
      await tester.pump(const Duration(milliseconds: 100));
      expect(searchInvocations, hasLength(1));
      expect(searchInvocations.first, equals('Lahore'));

      // Clean up
      debounceTimer?.cancel();
    });

    testWidgets('short queries (length <= 1) cancel timer and do not trigger search', (WidgetTester tester) async {
      Timer? debounceTimer;
      final List<String> searchInvocations = [];

      void onSearchTextChanged(String value) {
        debounceTimer?.cancel();
        if (value.trim().length <= 1) {
          return;
        }
        debounceTimer = Timer(const Duration(milliseconds: 500), () {
          searchInvocations.add(value.trim());
        });
      }

      onSearchTextChanged('Lahore');
      await tester.pump(const Duration(milliseconds: 200));

      // User clears or deletes characters to <= 1
      onSearchTextChanged('L');
      await tester.pump(const Duration(milliseconds: 600));

      expect(searchInvocations, isEmpty);
    });
  });
}
