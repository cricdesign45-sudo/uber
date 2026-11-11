## 2025-05-18 - Eliminating setState in Flutter build() methods
**Learning:** In Flutter applications, triggering computations that call `setState()` inside the `build()` method triggers re-entrancy / extra build passes and causes UI thrashing or frame drops.
**Action:** Decouple computations into pure functions and update component state only in response to events (e.g. API responses or user interactions), consolidating multiple state updates into single `setState()` calls.
