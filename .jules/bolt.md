# Bolt's Journal

## 2025-05-18 - Isolated Unit Testing in Legacy Flutter Codebases
**Learning:** Full `flutter test` across all files in `uber_users_app` fails due to an outdated dependency (`rounded_loading_button: 2.1.0` using removed `onSurface` parameter in Material `ElevatedButton.styleFrom`). However, targeted unit tests targeting non-UI logic pass cleanly without triggering compilation errors from broken dependencies.
**Action:** When verifying optimizations in sub-projects with broken legacy dependencies, run isolated targeted unit tests (e.g. `flutter test test/specific_test.dart`) rather than full test suites.
