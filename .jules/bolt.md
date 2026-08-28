## 2025-05-18 - Map Indexing for Frequently Updated Collections
**Learning:** In Flutter apps receiving high-frequency realtime location streams (e.g. GeoFire location updates), scanning lists with `indexWhere` to update or remove items creates unnecessary $O(N)$ overhead per location tick. Maintaining a Map index alongside the list yields $O(1)$ updates and removals.
**Action:** Always complement list representations of real-time entities with a Map index keyed by unique ID when frequent lookup/update/removal operations occur.
