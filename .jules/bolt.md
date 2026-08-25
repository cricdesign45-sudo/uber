## 2024-08-25 - Synchronizing HashMap Index with List Data Structures
**Learning:** Adding a static index `Map` alongside a `List` speeds up lookups ($O(1)$) and location updates, but operations like `clear()` must be encapsulated via explicit methods (e.g. `clearDriversList()`) to prevent state desynchronization between map and list.
**Action:** Always provide dedicated helper methods for list modification when paired with an internal lookup Map index.
