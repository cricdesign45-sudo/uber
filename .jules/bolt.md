## 2025-02-18 - Preserve pubspec.lock during Flutter tooling commands
**Learning:** Running commands like `flutter analyze` or `flutter pub get` in subprojects can automatically update `pubspec.lock` with newer Dart SDK constraints and transitive dependency updates, which may cause unintended diffs or build pipeline incompatibilities.
**Action:** Always verify `git status` after running Flutter toolchain commands and revert unintended `pubspec.lock` changes before committing.
