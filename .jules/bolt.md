## 2025-02-21 - Debounce Search Input API Calls

**Learning:** Un-throttled search inputs triggering external API requests on every keystroke (e.g., Google Places Autocomplete API) create severe performance degradation: high latency, wasted mobile bandwidth/battery, unnecessary backend load, and API rate limit exhaustion.
**Action:** Always wrap text field input search handlers with a `Timer` debounce mechanism (300-400ms) and ensure timer/controller instances are properly cancelled and disposed in `dispose()` to prevent memory leaks and redundant network requests.
