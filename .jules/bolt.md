## 2025-05-18 - Map-Backed Lookup for Frequent Geofire Streams
**Learning:** Frequent location stream callbacks (such as GeoFire `onKeyEntered`, `onKeyExited`, `onKeyMoved`) cause performance degradation when searching lists via linear `indexWhere` O(N) operations.
**Action:** Maintain a companion `Map<String, T>` indexed by ID for O(1) lookups alongside `List<T>` when UI list ordering/iterability is required.
