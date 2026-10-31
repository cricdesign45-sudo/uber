# Bolt's Performance Journal

## 2024-05-18 - Debouncing External API Calls in Search Input
**Learning:** In Flutter text fields with autocompletion / search queries against rate-limited cloud APIs (like Google Places Autocomplete), wiring `onChanged` directly to network methods causes excessive network traffic, battery drain, and out-of-order response race conditions.
**Action:** Always wrap text-driven network searches with a 500ms `Timer` debounce and clean up pending timers in `dispose()`.
