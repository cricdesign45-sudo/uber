## 2024-09-03 - Debouncing Places API search input in Flutter
**Learning:** Live search input in Flutter text fields without debouncing triggers an HTTP network call per keystroke, consuming heavy API quota and causing unnecessary rebuilds/renders.
**Action:** Always wrap live text field search inputs with a `Timer` debouncer (~400ms delay) and ensure the timer is cancelled in `dispose()`.
