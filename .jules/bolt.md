# Bolt's Performance Journal

## 2026-11-02 - Debounce Google Places Autocomplete API Requests
**Learning:** In Flutter text search inputs, triggering network calls directly in `TextField.onChanged` fires unthrottled HTTP requests for every character typed. In this codebase, the destination search was querying Google Places Autocomplete on every keystroke, consuming heavy network bandwidth and API quota.
**Action:** Always wrap text-driven search queries in a `Timer` with a ~300-400ms debounce interval, cancel previous pending timers on subsequent inputs, and ensure cancellation in `dispose()` to prevent memory leaks and post-unmount execution.
