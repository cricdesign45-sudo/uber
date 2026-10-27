## 2025-05-18 - Debouncing Live Search Input in Flutter Apps

**Learning:** Search text inputs triggering network API calls on every keystroke (`onChanged`) flood the network, cause response race conditions where older requests overwrite newer ones, and waste bandwidth/API quota. A 300ms `Timer` debounce mechanism reduces network requests by ~80% while typing.
**Action:** Always check `onChanged` handlers attached to `TextField` for un-debounced async API calls and wrap them in a timer-based debouncer that cancels pending timers on new keystrokes and during `dispose()`.
