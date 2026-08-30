## 2025-05-18 - Avoid calling setState inside Flutter build method
**Learning:** Calling `setState()` synchronously inside a Flutter widget's `build()` method causes unnecessary widget lifecycle overhead and schedules redundant frame updates during the build phase.
**Action:** Calculate derived state values directly during `build()` as local variables or compute/update state within explicit user action callbacks / event handlers rather than calling `setState()` while building the widget tree.
