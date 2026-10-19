## 2025-05-18 - Avoid setState and heavy recalculations inside Flutter build methods
**Learning:** Calling `setState` or executing state-mutating recalculations inside Flutter `build()` methods causes continuous redundant frame rebuilds and performance degradation.
**Action:** Always compute derived values via pure getters or trigger recalculations explicitly within event/callback handlers where state actually changes, rather than calculating inside `build()`.
