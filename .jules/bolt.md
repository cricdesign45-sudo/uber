## 2025-05-18 - [RegExp Compilation Optimization]
**Learning:** Instantiating `RegExp` repeatedly inside functions or non-static class instances causes unnecessary compilation overhead on every invocation or instance creation.
**Action:** Always compile `RegExp` objects as `static final` constants to compile regex patterns once during class loading.
