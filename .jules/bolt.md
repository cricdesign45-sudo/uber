## 2025-05-18 - Swap-with-last strategy for O(1) list management with index map
**Learning:** Maintaining a `List<T>` for existing callers while adding an index map `Map<String, int>` allows $O(1)$ lookups, updates, and removals (using swap-with-last) without returning copied lists that break references or cause $O(N)$ allocations.
**Action:** When optimizing static lists accessed directly by UI components, combine an index map with swap-with-last removal to preserve direct list access and avoid extra allocations.
