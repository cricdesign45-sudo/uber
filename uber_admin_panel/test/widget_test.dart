import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('Uber Admin Panel'),
      ),
    ));
    expect(find.text('Uber Admin Panel'), findsOneWidget);
  });
}
