## 2025-05-24 - Places API Debouncing and Map Marker State Updates
**Learning:** The place autocomplete search input triggered HTTP network requests on every keystroke (`onChanged`), causing network congestion and unnecessary re-renders. Additionally, streaming driver location updates in `HomePage` called `setState` twice per update (once to clear markers and once to assign new markers), doubling map re-render cycles.
**Action:** Apply a 300ms `Timer` debounce to search input handlers and build marker sets in memory before calling `setState` a single time for map marker updates.
