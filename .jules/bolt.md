## 2025-05-18 - [Debounce Autocomplete Place Search API Requests]
**Learning:** `TextField.onChanged` directly invoking API calls (`CommonMethods.sendRequestToAPI`) on every character typed sends unnecessary network requests to Google Maps Places API and can lead to race conditions with out-of-order responses.
**Action:** Use a 300ms `Timer` debounce mechanism in `StatefulWidget`s handling live search inputs, and ensure `_timer?.cancel()` is called in `dispose()`.
