## 2025-05-18 - O(1) Index Map for Real-time Geofire Driver Tracking
**Learning:** In Flutter real-time tracking applications, performing linear scans (`List.indexWhere`) on driver lists for frequent GeoFire location updates (`onKeyMoved`, `onKeyExited`) creates linear O(N) runtime overhead and degrades performance as driver density increases.
**Action:** Use a complementary index map (`Map<String, T>`) alongside lists to achieve O(1) constant-time lookups, updates, and removals while preserving list reference stability and zero allocation overhead.
