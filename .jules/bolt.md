## 2025-05-18 - Debouncing Text Field Input for External Places API
**Learning:** Triggering HTTP GET requests to Google Places Autocomplete API on every single keystroke causes high network overhead, rate limits, UI lag, and unwanted billing.
**Action:** Always debounce text input with a 300ms `Timer` in `StatefulWidget` (and cancel the timer in `dispose()`) when querying autocomplete/search APIs.
