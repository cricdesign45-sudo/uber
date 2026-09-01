## 2026-05-18 - Safe Map Indexing for List Operations

**Learning:** When using an auxiliary Map index to optimize List lookup/removal from O(N) to O(1), always validate `list[index].id == expectedId` before modifying elements at the index. If `list` is mutable or accessible elsewhere, index map drift can silently corrupt the wrong element if unvalidated.

**Action:** Add validation helpers (`_isValidIndex`) checking both bounds and key identity before mutating indexed elements, with fallback rebuilding mechanisms when out-of-sync state is detected.
