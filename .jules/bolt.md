## 2025-05-18 - Debounce Google Places Autocomplete API Requests
**Learning:** `TextField.onChanged` in `SearchDestinationPlace` dispatches HTTP GET requests to Google Places Autocomplete on every single keystroke, causing high network traffic and unnecessary widget re-renders.
**Action:** Always apply a 300-400ms `Timer` debounce on location search inputs and cancel pending timers in `dispose()`.
