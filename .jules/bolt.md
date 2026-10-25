## 2025-05-18 - HashMap Lookup Index for Real-Time GeoFire Streaming
**Learning:** High-frequency location streaming events (GeoFire onKeyMoved) causing O(N) linear searches on driver lists can cause UI lag. Utilizing a Map index alongside list representations provides O(1) location updates. Care must be taken to ensure both map and list static references are cleared or synchronized together.
**Action:** Always maintain helper methods (e.g., `addDriver`, `clearAllDrivers`) that manipulate both state structures simultaneously to avoid state desynchronization bugs.
