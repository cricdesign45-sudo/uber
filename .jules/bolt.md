## 2025-08-16 - Flutter Build Phase `setState` Anti-Pattern

**Learning:** Calling `setState()` synchronously inside Flutter's `build()` method causes redundant rebuilds, unnecessary re-render overhead, and potential framework warnings or schedule-frame exceptions.
**Action:** Keep the `build()` method pure by computing derived UI values directly or refactoring calculations into pure getter/helper functions, leaving `setState()` strictly for user interaction or asynchronous state updates.
