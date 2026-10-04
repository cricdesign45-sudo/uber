## 2025-05-18 - Avoid Executing `setState` During Flutter `build` Phase

**Learning:** Invoking functions that execute `setState` during or as part of the `build()` lifecycle method in Flutter causes immediate, repeated re-render cycles and frame drops. When computed state (such as fares or time estimates derived from model properties) is needed during rendering, compute it cleanly as local variables or helper methods within the build method instead of storing it into State variables via `setState`.

**Action:** Whenever derived UI calculations depend on current widget state or models during `build()`, compute them functionally during the build pass or update them exclusively in event handlers/listeners. Never call `setState` within the widget `build` method.
