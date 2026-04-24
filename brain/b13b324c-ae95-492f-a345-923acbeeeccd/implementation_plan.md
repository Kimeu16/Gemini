# Fix Slow Page Loading on Sidebar Navigation

## Problem
Several pages take too long to load when clicking sidebar links. The root causes are identified from deep code analysis.

## Root Causes Found

### 🔴 Critical: Duplicate API Calls (Requests Page)
The `Requests.tsx` page fires **two identical `/employees` API calls** simultaneously:
- Line 584: `queryKey: ["employees"]` — for filter dropdown
- Line 594: `queryKey: ["allEmployees"]` — for handover dropdowns
Both call the exact same endpoint `api.get("/employees")` but use different query keys, so React Query treats them as separate requests.

### 🔴 Critical: CalendarView Pagination Loop
`CalendarView.tsx` (line 270-281): For managers, it fetches **ALL leave requests in a while loop**, paginating 100 at a time. This creates multiple sequential API calls that block rendering:
```js
while (hasMore) {
  const response = await api.get(`/leave-requests?page=${page}&limit=100`);
  hasMore = response.data.hasNextPage;
  page++;
}
```

### 🔴 Critical: Reports Fetches 1000 Records at Once
`Reports.tsx` (line 132): Fetches all leave requests with `limit=1000` in a single massive API call:
```js
api.get("/leave-requests?limit=1000")
```

### 🟡 Major: Dashboard Waterfall Pattern
Each dashboard (OM, GM, CEO) fires **4 parallel API calls** but blocks rendering until ALL complete:
- `/stats/overview`
- `/stats/departments`
- `/employees/me`
- `/leave-requests?status=PENDING_OM`
Line 227-235 in `OMDashboard.tsx`: `const isLoading = statsLoading || requestsLoading || employeeLoading;` — shows NOTHING until every query resolves.

### 🟡 Major: Sidebar Notification Polling
`Sidebar.tsx` (line 82-89): Fetches `/notifications` every 30 seconds — runs on every page, adding network overhead.

### 🟡 Major: Staggered Animation Delays
Employee cards use `transition={{ delay: index * 0.1 }}` (line 523, Employees.tsx). With 30+ employees, the last card doesn't appear until 3+ seconds after data arrives, making it **feel** slow.

## Proposed Changes

### 1. Fix Duplicate Employee API Calls (Requests.tsx)
Remove the duplicate `allEmployees` query and reuse the `employees` query data.

### 2. Fix Dashboard Waterfall (OMDashboard, GMDashboard, CEODashboard)
Show content progressively — render stat cards as soon as stats arrive, don't wait for all queries.

### 3. Cap Animation Delays (Employees.tsx)
Cap the animation delay so it never exceeds 0.5s regardless of list length.

### 4. Optimize CalendarView Pagination
Fetch with a larger limit (500) to reduce round-trips, or use a single request.

### 5. Optimize Reports Data Fetching
Add abort signal and use React Query's staleTime to cache report data.

### 6. Optimize Sidebar Notification Polling
Increase poll interval from 30s to 60s and add staleTime.

## Verification Plan
- Run dev server and test each page transition after fixes
- Confirm no duplicate API calls in Network tab
- Confirm progressive rendering on dashboards
