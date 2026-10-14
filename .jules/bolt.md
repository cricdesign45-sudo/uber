## 2025-05-18 - Dual Data Structure Sync for High-Frequency Spatial Lookups
**Learning:** Frequent GeoFire/Realtime updates on collections (like driver location updates) cause heavy $O(N)$ linear scans when using `List.indexWhere`. Introducing a companion `Map<String, T>` enables $O(1)$ updates and removals, but `add` logic must mutate existing object instances in-place if key exists to prevent list-map instance desynchronization and reference leaks.
**Action:** Always update existing object fields in-place when synchronizing dual List/Map cache structures.
