## 2025-02-18 - Debouncing Places Autocomplete API Requests
**Learning:** In Flutter text fields for place autocomplete searching (such as Google Places API), invoking network requests on every `onChanged` event causes N HTTP requests for an N-character string. This consumes network bandwidth, battery, and API rate limits, and can introduce out-of-order response rendering issues.
**Action:** Always implement a 300–400ms `Timer` debounce mechanism for real-time text input search handlers in Flutter applications and ensure `_timer?.cancel()` is called in `dispose()`.
