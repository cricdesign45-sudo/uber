## 2025-05-18 - Optimize Nearby Drivers Map Lookups in Flutter
**Learning:** Geofire position updates and driver list updates trigger linear scans ($O(n)$) when using `List.indexWhere` to update or remove drivers. Maintaining a `Map<String, OnlineNearbyDrivers>` alongside the list reduces lookup, removal, and location updates to constant time ($O(1)$).
**Action:** Always maintain a key-indexed map alongside lists when managing dynamic collections that undergo frequent ID-based lookups and location updates.
