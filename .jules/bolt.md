## 2025-05-18 - RegExp Compilation Caching
**Learning:** Instantiating `RegExp` inside frequent form-validation callbacks or non-static class fields recompiles the regex pattern and allocates memory on each call. Declaring regexes as `static final` caches the compiled regex instance across all validations.
**Action:** Always extract static regular expressions into `static final` fields when validating input in Flutter forms/providers.
