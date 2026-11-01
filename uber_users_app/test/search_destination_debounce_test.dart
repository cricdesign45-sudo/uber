import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:uber_users_app/appInfo/app_info.dart';
import 'package:uber_users_app/models/address_models.dart';
import 'package:uber_users_app/pages/search_destination_place.dart';

void main() {
  testWidgets('SearchDestinationPlace renders and accepts input with debouncing',
      (WidgetTester tester) async {
    final appInfo = AppInfoClass();
    final address = AddressModel();
    address.humanReadableAddress = "123 Main St, Springfield";
    appInfo.updatePickUpLocation(address);

    await tester.pumpWidget(
      ChangeNotifierProvider<AppInfoClass>.value(
        value: appInfo,
        child: const MaterialApp(
          home: SearchDestinationPlace(),
        ),
      ),
    );

    // Initial render check
    expect(find.text("Set Dropoff Location"), findsOneWidget);
    expect(find.text("123 Main St, Springfield"), findsOneWidget);

    // Find Destination text field
    final destinationField = find.widgetWithText(TextField, "Destination Address");
    expect(destinationField, findsOneWidget);

    // Enter short text (< 2 chars), should not trigger debounce query
    await tester.enterText(destinationField, "A");
    await tester.pump(const Duration(milliseconds: 200));

    // Fast successive typing simulates real user typing before debounce interval completes
    await tester.enterText(destinationField, "Cent");
    await tester.pump(const Duration(milliseconds: 100));

    await tester.enterText(destinationField, "Central");
    await tester.pump(const Duration(milliseconds: 100));

    await tester.enterText(destinationField, "Central Park");
    // Advance time past the 400ms debounce threshold
    await tester.pump(const Duration(milliseconds: 500));

    // Clear input to test short-circuit clearing logic
    await tester.enterText(destinationField, "");
    await tester.pump(const Duration(milliseconds: 500));

    // Ensure widget tree unmounts cleanly and calls dispose()
    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
    await tester.pumpAndSettle();
  });
}
