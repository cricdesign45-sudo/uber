## 2026-03-30 - Debouncing Location Search API Calls in Flutter
**Learning:** Location input textfields connected directly to API endpoints execute expensive network requests on every single character change, leading to network congestion, potential race conditions on response handling, and excessive API usage/costs.
**Action:** Always implement a 400ms debounce timer with cancellation on text changes and widget disposal when binding TextField `onChanged` handlers to remote search APIs.
