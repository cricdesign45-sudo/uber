## 2025-05-18 - Map Indexing for Real-Time Geo Tracking Stream Updates
**Learning:** In real-time location tracking apps, frequent updates (like Geofire stream events) using `List.indexWhere()` cause $O(N)$ lookup overhead on every tick. Maintaining an internal `Map<String, T>` index optimizes lookups/updates to $O(1)$ time while preserving list order and compatibility for UI rendering.
**Action:** Use map indexing for any collection that receives frequent update events by key/ID, while keeping fallback logic for backward-compatible list mutations.
