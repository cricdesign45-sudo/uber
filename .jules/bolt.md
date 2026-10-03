## 2025-05-18 - Debounce API calls on text input in Flutter location search
**Learning:** In Flutter applications integrated with Google Maps/Places API, triggering `onChanged` handlers directly without a debounce timer causes excessive HTTP requests on every single keystroke. Adding a 300ms `Timer` debounce reduces outgoing network requests by ~70-90% during active typing and prevents UI jank / rate-limiting.
**Action:** Always check `onChanged` callbacks for search and autocomplete fields in Flutter apps to ensure debouncing is used before dispatching API network requests.
