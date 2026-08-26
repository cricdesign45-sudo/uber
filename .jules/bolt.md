## 2025-05-18 - Prevent setState and Computation in Flutter build() Method
**Learning:** Performing state recalculation (like fare amount string parsing) and scheduling state updates (`setState`) inside Flutter's `build()` method causes unnecessary computations on every frame render and can trigger framework warnings.
**Action:** Extract computation methods outside of `build()` and invoke them explicitly in event handlers or state transition callbacks where the underlying state actually changes.
