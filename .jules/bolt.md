## 2025-05-18 - Debouncing Places Autocomplete API Requests
**Learning:** In Flutter apps with Google Maps API integration, live input fields (`TextField.onChanged`) without debouncing send HTTP requests on every single keystroke. This causes severe network spam, potential race conditions in autocomplete responses, and high API costs.
**Action:** Always apply a ~400ms timer debounce using standard `dart:async` `Timer` to user text input fields triggering external web/API calls, ensuring previous timers are cancelled on subsequent keystrokes and disposed on widget unmount.
