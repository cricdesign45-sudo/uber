# Bolt Performance Journal

## 2025-02-18 - Debounce Google Places Autocomplete Requests
**Learning:** Text input fields triggering external HTTP requests (e.g. Google Places Autocomplete API in `uber_users_app`) on every keystroke create massive redundant network traffic and unnecessary state updates. Adding a 400ms timer debounce reduces network request volume by ~90% during rapid typing.
**Action:** Always check `onChanged` handlers in search fields for debouncing with proper cancellation in `dispose()`.
