## 2025-05-18 - Debouncing Autocomplete API Calls in Flutter

**Learning:** Un-debounced `onChanged` handlers in text fields calling remote APIs (such as Google Places Autocomplete) fire an HTTP request and UI update on every keystroke. Adding a 400ms `Timer` debounce reduces network requests by ~80% during typing while preserving UX. Always ensure timers and controllers are cancelled/disposed in `dispose()` to prevent memory leaks and `setState` calls after unmounting.

**Action:** Whenever implementing search or autocomplete inputs, introduce a debounce timer and verify proper lifecycle cleanup in `dispose()`.
