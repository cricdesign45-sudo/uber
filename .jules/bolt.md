## 2025-05-18 - Debouncing Places API Autocomplete Requests in Flutter
**Learning:** Live search `TextField.onChanged` inputs without debouncing trigger rapid network requests on every keystroke, consuming Google Maps API quota and causing main-thread UI jank during rapid typing.
**Action:** Always implement a 300-400ms `Timer` debounce on location search inputs and ensure the timer is cancelled in `dispose()` to prevent post-unmount callbacks.
