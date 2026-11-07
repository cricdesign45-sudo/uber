# Bolt's Performance Journal

## 2026-02-18 - GeoFire Driver Location Stream Linear Lookups
**Learning:** In `uber_users_app`, GeoFire `onKeyMoved` events fire continuously on the main Flutter UI isolate as nearby drivers stream GPS location updates. Linear scans (`indexWhere`) on `List<OnlineNearbyDrivers>` produce an $O(N)$ penalty per update, which degrades UI responsiveness during active location polling with many drivers.
**Action:** Pair `nearbyOnlineDriversList` with an $O(1)$ hash map lookup (`nearbyOnlineDriversMap`), updating coordinates in place in $O(1)$ while keeping list references synchronized for downstream map rendering.
