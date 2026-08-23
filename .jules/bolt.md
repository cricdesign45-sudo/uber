## 2025-05-18 - Avoid setState during Widget build() in Flutter

**Learning:** Calling `setState()` or methods that invoke `setState()` inside a Flutter widget's `build()` method creates continuous re-render scheduling, frame stutter, high CPU usage, and potential runtime framework exceptions.
**Action:** Always compute derived UI state directly/purely during `build()` or move state-mutating operations into explicit event handlers (like `onTap`, `onChanged`) or async request completions.
