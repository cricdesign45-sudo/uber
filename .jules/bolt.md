## 2025-05-18 - Debouncing Places API Autocomplete Requests
**Learning:** Text search inputs sending raw HTTP requests on every keystroke create severe network spam and excessive main-thread re-renders in Flutter apps.
**Action:** Always wrap `onChanged` search callbacks in a 300-400ms `Timer` debounce and properly cancel the timer in `dispose()`.
