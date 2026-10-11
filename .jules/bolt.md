## 2025-05-15 - In-place Mutation vs. List Allocation in High-Frequency Location Streaming
**Learning:** High-frequency event streams (like Realtime Database / GeoFire driver location updates) should mutate existing object instances in-place within map collections rather than calling `.values.toList()` on every update. Rebuilding lists on every coordinate update causes heavy garbage collection overhead.
**Action:** Use Map key lookups for O(1) mutations on existing objects, and only trigger list reconstruction or synchronization when items are explicitly added or removed.
