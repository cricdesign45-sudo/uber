## 2026-02-18 - Geofire Stream Updates & O(1) Index Lookup
**Learning:** Geofire streams frequent real-time position updates (`onKeyMoved`, `onKeyExited`) for nearby drivers. Managing drivers in a flat `List` using linear scans (`indexWhere`) causes unnecessary O(N) CPU load on the UI thread for every position event.
**Action:** Pair the driver list with a driver ID-to-index lookup map to achieve O(1) updates and removals without breaking callers that expect `List<OnlineNearbyDrivers>`.
