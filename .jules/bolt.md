## 2025-05-18 - Eliminating `setState()` Calls During `build()` in Flutter Pages

**Learning:** In `HomePage` (`uber_users_app`), helper functions like `calculateFareAndTime()` were being invoked synchronously during `build()` and contained `setState()` calls. Calling `setState()` during `build()` triggers continuous re-render loops and CPU thrashing in Flutter.
**Action:** Always compute derived UI values directly in `build()` or helper methods without calling `setState()`. Reserve `setState()` exclusively for user interactions or async event callbacks.
