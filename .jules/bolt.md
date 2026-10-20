## 2025-05-18 - [Dart RegExp Caching]
**Learning:** Instantiating `RegExp` inside functions or instance fields in Dart recompiles the pattern on every call or instance creation. Hoisting them to `static final RegExp` caches the compiled regex pattern across invocations.
**Action:** Always declare fixed validation regexes as `static final RegExp` in Dart classes to avoid unnecessary re-parsing and GC overhead.
