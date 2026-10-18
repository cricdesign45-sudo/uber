## 2025-05-18 - $O(1)$ Hash Map Lookups for Geofire Real-time Driver Location Updates
**Learning:** In Flutter/Dart apps processing rapid WebSocket or Geofire location stream callbacks, storing active entities in `List<T>` with `indexWhere` introduces an $O(N)$ overhead per location tick. Using a companion `Map<String, T>` index reduces lookups to $O(1)$, maintaining list order while eliminating linear scanning overhead.
**Action:** Always complement dynamic entity lists with a key-indexed map when handling frequent item updates or removals.
