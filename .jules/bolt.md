## 2025-05-20 - High-Frequency GeoFire Streams & Isolated Flutter Unit Testing

**Learning:** High-frequency real-time location update events from GeoFire invoke list manipulation methods continuously. Using `indexWhere` with anonymous closures allocates closure functions on every tick, and pairing `indexWhere` with `removeAt` performs duplicate list iterations. Replacing `indexWhere` + `removeAt` with `removeWhere` enables single-pass removal, and using indexed `for` loops with early returns prevents closure allocations during location update streams.

Additionally, full `flutter test` execution in `uber_users_app` fails due to pre-existing third-party dependency (`rounded_loading_button: 2.1.0`) compile issues with newer Flutter SDKs. Running targeted unit tests (`flutter test test/path_to_test.dart`) bypasses unaffected widget dependencies.

**Action:** Look for closure allocations inside stream listener callbacks and replace double-pass index searches with single-pass list operations (`removeWhere`) or direct `for` loops. Run target-specific unit test paths when third-party packages fail full suite compilation.
