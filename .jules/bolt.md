## 2025-05-18 - Debouncing Search Inputs to Prevent API Storms

**Learning:** Location search `TextField`s without debouncing trigger Google Places Autocomplete API requests on every single keystroke. This causes massive network request overhead (~80-90% redundant calls), potential out-of-order race conditions, and rapid unnecessary `setState` re-renders.

**Action:** Always wrap search input handlers that trigger network requests with a `Timer` debounce (e.g., 400ms) in Flutter/Dart, and ensure `Timer` cancellation in `dispose()` to prevent memory leaks and redundant network traffic.
