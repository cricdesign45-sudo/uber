## 2025-05-18 - GeoFire Driver Updates O(1) Index Lookup
**Learning:** Frequent location streaming events via GeoFire (`onKeyMoved`, `onKeyExited`) previously caused repeated linear scans (`indexWhere`) on the nearby drivers list. By keeping an index cache (`_driverIndexMap`), location updates and removals are executed in O(1) time without changing the public List API or breaking downstream subscribers.
**Action:** In real-time tracking features, index collections by unique ID while preserving list order to maintain fast random updates during rapid map streaming events.
