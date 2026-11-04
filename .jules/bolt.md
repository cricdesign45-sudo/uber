# Bolt's Journal - Critical Learnings

## 2025-05-14 - Place Autocomplete Keystroke Flooding
**Learning:** In `uber_users_app`, `SearchDestinationPlace` dispatched unthrottled HTTP requests to the Google Places Autocomplete API on every single character change in the destination `TextField`. For typical user typing speed (~4-6 chars/sec), typing a destination name triggered unnecessary back-to-back network calls and billable API queries.
**Action:** Always debounce text search input listeners (e.g. 300-400ms duration) and ensure active `Timer` handles and `TextEditingController`s are properly cleaned up in `dispose()` to prevent memory leaks and dangling async work.
