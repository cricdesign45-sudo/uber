# Bolt's Journal - Critical Learnings

## 2025-05-18 - GeoFire Driver Stream O(1) Optimization
**Learning:** Frequent location stream events (e.g., GeoFire `onKeyMoved` / `onKeyExited`) in Flutter apps iterate over driver lists on every update. Using linear search `indexWhere` creates $O(N)$ overhead per stream packet, which scales poorly as driver count grows.
**Action:** Always maintain a primary key map (`Map<String, T>`) for entity collections populated by high-frequency realtime socket/stream events to ensure $O(1)$ updates and removals.
