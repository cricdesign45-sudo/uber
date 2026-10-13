## 2025-03-03 - Debouncing Flutter Search TextFields & Flutter Pub Lockfiles

**Learning:** In Flutter location search screens, triggering network API calls on every `onChanged` keystroke causes high API volume, unnecessary rebuilds, and out-of-order response race conditions. Adding a 300ms `Timer` debouncer eliminates up to 80-90% of redundant requests. Additionally, running `flutter analyze` or `flutter test` automatically runs `flutter pub get` which updates `pubspec.lock`; lockfile changes must be unstaged before committing if lockfile modification is forbidden.

**Action:** Always wrap `onChanged` handlers that make network or expensive async requests with a debouncer timer and dispose the timer in `dispose()`. Revert lockfiles if package dependencies weren't intended to change.
