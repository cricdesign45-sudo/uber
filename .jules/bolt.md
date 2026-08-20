## 2025-05-18 - Avoid TextEditingController Updates and Un-debounced API Calls in Flutter Build/Input Handlers

**Learning:** Mutating `TextEditingController.text` inside the `build()` method causes continuous controller updates on every frame/rebuild and resets text selections. Additionally, calling external Places APIs directly inside `onChanged` without debouncing creates excessive network requests and unnecessary rebuilds.

**Action:** Initialize `TextEditingController` initial values in `initState()` or via `addPostFrameCallback`, and debounce `onChanged` API network calls using a `Timer` (e.g., 400ms) with proper cancellation in `dispose()`.
