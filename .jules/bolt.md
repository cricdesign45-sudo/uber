## 2025-05-10 - Search Input Debouncing in Location Autocomplete
**Learning:** In Flutter text fields triggering network API requests (such as Google Places Autocomplete in `SearchDestinationPlace`), missing input debouncing results in an API call per keystroke, causing network overhead, rate-limiting risks, and UI state churn.
**Action:** Always wrap text input `onChanged` API handlers with a 400ms `Timer` debounce and dispose the timer in the `State` class's `dispose()` lifecycle method to prevent memory leaks.
