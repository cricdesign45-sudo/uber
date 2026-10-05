## 2025-05-18 - Debouncing Location Search Autocomplete Inputs
**Learning:** Location/address search fields that trigger external API requests on `onChanged` flood the network and cause rapid re-renders if not debounced.
**Action:** Always wrap search input handlers that make API requests in a 300ms–400ms `Timer` debouncer and cancel the timer in `dispose()`.
