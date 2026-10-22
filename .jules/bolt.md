## 2025-05-10 - Avoid state calculations inside Flutter widget build() methods
**Learning:** Performing fare and time string calculations directly in Flutter's `build()` method causes unnecessary computation on every render frame and can trigger invalid state updates during build cycles.
**Action:** Move state updates and heavy calculations to event handlers (e.g. API completion callbacks, user tap handlers) and cache compiled `RegExp` objects as `static final` members.
