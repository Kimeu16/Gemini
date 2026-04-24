## Backend
- [ ] Prisma schema: Rename CEO fields to Admin fields
- [ ] constants.ts: Remove CEO role
- [ ] leave.controller.ts: Replace all CEO references
- [ ] reservation.controller.ts: Replace all CEO references
- [ ] leave.routes.ts: Update authorize arrays and route name
- [ ] employee.routes.ts: Update authorize arrays
- [ ] audit.routes.ts, carryforward.routes.ts, debug.routes.ts
- [ ] Push schema & re-seed local DB

## Frontend
- [ ] types/leave.ts: Update Role and LeaveStatus types
- [ ] hooks/useRoleAccess.ts: Rename isCEO → isAdmin
- [ ] Rename CEODashboard.tsx → AdminDashboard.tsx
- [ ] Dashboard.tsx: Update import and case
- [ ] Requests.tsx: Replace all CEO references
- [ ] MyHistory.tsx: Replace statuses and labels
- [ ] Settings.tsx, Employees.tsx: Replace CEO role checks
- [ ] CalendarView.tsx: Replace status config
- [ ] UserGuide.tsx: Replace CEO guide with Admin guide
- [ ] StatusBadge.tsx, ApprovalTimeline.tsx, FullCalendarView.tsx
- [ ] PendingReservations.tsx, EmployeeDashboard.tsx
- [ ] corporatePdf.ts: Replace role checks (keep CEO label)
- [ ] Sidebar.tsx (if needed)

## Verification
- [ ] Prisma push + seed
- [ ] Server startup check
- [ ] Browser test
