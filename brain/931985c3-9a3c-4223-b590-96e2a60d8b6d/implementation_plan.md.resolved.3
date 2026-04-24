# Replace CEO Role with ADMINISTRATOR in Approval Workflow

## Summary

Replace all references to the `CEO` role with the existing `ADMINISTRATOR` role across the entire codebase. The approval flow changes from `HOD/OM → GM → CEO` to `HOD/OM → GM → ADMIN`. The Admin acts as the CEO's proxy — updating the system after the CEO has manually signed the printed PDF.

> [!IMPORTANT]
> **PDF/UI Labels**: The "Chief Executive Officer" label on generated PDFs and the approval signature section **will NOT change** — the CEO still manually signs the printed document. The Admin simply records the outcome in the system.

## User Review Required

> [!WARNING]
> **Database Schema Migration**: This plan renames Prisma schema fields (`ceoApproverId` → `adminApproverId`, etc.) and status values (`PENDING_CEO` → `PENDING_ADMIN`, `REJECTED_CEO` → `REJECTED_ADMIN`). This requires a Prisma migration. Since we're using the fresh local Docker database, there is **zero risk of data loss**. However, when you later apply this to production (VM), you will need to run the migration carefully — I will include a migration script that handles existing data.

---

## Proposed Changes

### Database Layer

#### [MODIFY] [schema.prisma](file:///c:/Apps/Leave%20Tracker/server/prisma/schema.prisma)
- **User model**: Rename `ceoReservationApprovals` → `adminReservationApprovals` and relation name `CEOReservationApprover` → `AdminReservationApprover`
- **Reservation model**: Rename fields:
  - `ceoApprovalDate` → `adminApprovalDate`
  - `ceoApproverId` → `adminApproverId`  
  - `ceoApprover` relation → `adminApprover`

---

### Backend — Controllers

#### [MODIFY] [leave.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/leave.controller.ts)
- **createLeaveRequest** (L232–282): Replace `CEO` role checks with `ADMINISTRATOR`; change `PENDING_CEO` → `PENDING_ADMIN`
- **gmApproveLeaveRequest** (L802–985): Change status from `PENDING_CEO` → `PENDING_ADMIN`; notify `ADMINISTRATOR` users instead of `CEO`; update email content labels
- **ceoApproveLeaveRequest** (L987–1152): Rename function to `adminApproveLeaveRequest`; change status check from `PENDING_CEO` → `PENDING_ADMIN`; update log action strings
- **rejectLeaveRequest** (L1154–1266): Replace `PENDING_CEO`/`REJECTED_CEO` with `PENDING_ADMIN`/`REJECTED_ADMIN`
- **Overlap check** (L168): Change `PENDING_CEO` → `PENDING_ADMIN` in the overlap status list

#### [MODIFY] [reservation.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/reservation.controller.ts)
- **notifyNextApprover** (L52–54): Change `PENDING_CEO` case to `PENDING_ADMIN`; notify `ADMINISTRATOR` role
- **createReservation** (L115–118): Replace `CEO` → `ADMINISTRATOR` role checks; `PENDING_CEO` → `PENDING_ADMIN`
- **handleReservation** (L184, L201–205, L225–228): Replace `CEO` → `ADMINISTRATOR` role authorization; `PENDING_CEO` → `PENDING_ADMIN` status transitions
- **getDepartmentReservations** (L353): Replace `CEO` in role list with `ADMINISTRATOR`
- **cancelReservation** (L450): Replace `CEO` in role list with `ADMINISTRATOR`

#### [MODIFY] [stats.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/stats.controller.ts)
- Replace any `CEO`/`PENDING_CEO` references with `ADMINISTRATOR`/`PENDING_ADMIN`

---

### Backend — Routes

#### [MODIFY] [leave.routes.ts](file:///c:/Apps/Leave%20Tracker/server/src/routes/leave.routes.ts)
- Replace all `'CEO'` in `authorize()` arrays with `'ADMINISTRATOR'`
- Rename import `ceoApproveLeaveRequest` → `adminApproveLeaveRequest`
- Rename route `/ceo-approve` → `/admin-approve`

#### [MODIFY] [employee.routes.ts](file:///c:/Apps/Leave%20Tracker/server/src/routes/employee.routes.ts)
- Replace all `'CEO'` in `authorize()` arrays with `'ADMINISTRATOR'`

#### [MODIFY] [audit.routes.ts](file:///c:/Apps/Leave%20Tracker/server/src/routes/audit.routes.ts)
- Replace `'CEO'` with `'ADMINISTRATOR'`

#### [MODIFY] [carryforward.routes.ts](file:///c:/Apps/Leave%20Tracker/server/src/routes/carryforward.routes.ts)
- Replace `'CEO'` with `'ADMINISTRATOR'`

#### [MODIFY] [debug.routes.ts](file:///c:/Apps/Leave%20Tracker/server/src/routes/debug.routes.ts)
- Update comment referencing CEO

---

### Backend — Utilities

#### [MODIFY] [constants.ts](file:///c:/Apps/Leave%20Tracker/server/src/utils/constants.ts)
- Remove `CEO: 'CEO'` from ROLES (already has `ADMIN: 'ADMINISTRATOR'`)

---

### Frontend — Types

#### [MODIFY] [leave.ts](file:///c:/Apps/Leave%20Tracker/src/types/leave.ts)
- Replace `'CEO'` with `'ADMINISTRATOR'` in Role type (already exists but needs to remove CEO)
- Replace `'PENDING_CEO'` → `'PENDING_ADMIN'` and `'REJECTED_CEO'` → `'REJECTED_ADMIN'` in LeaveStatus type

---

### Frontend — Pages

#### [MODIFY] [Requests.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Requests.tsx)
- Replace `PENDING_CEO` → `PENDING_ADMIN` in status checks (~8 locations)
- Replace `REJECTED_CEO` → `REJECTED_ADMIN`
- Replace `user?.role === "CEO"` → `user?.role === "ADMINISTRATOR"` (~6 locations)
- Rename `ceoApprove` mutation → `adminApprove`; update API endpoint from `/ceo-approve` to `/admin-approve`
- Keep "Chief Executive Officer" label in approval signature display (per user requirement)

#### [MODIFY] [Dashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Dashboard.tsx)
- Replace `case 'CEO':` → `case 'ADMINISTRATOR':`
- Rename `CEODashboard` import/usage → `AdminDashboard`

#### [MODIFY] [MyHistory.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/MyHistory.tsx)
- Replace `PENDING_CEO` → `PENDING_ADMIN` in status lists and filters
- Replace `REJECTED_CEO` → `REJECTED_ADMIN` in filter options
- Update display labels from "Pending CEO" → "Pending Admin"

#### [MODIFY] [Settings.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Settings.tsx)
- Replace `user?.role === 'CEO'` → `user?.role === 'ADMINISTRATOR'`

#### [MODIFY] [Employees.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Employees.tsx)
- Replace `user?.role === "CEO"` → `user?.role === "ADMINISTRATOR"` in permission checks
- Replace `"CEO"` in role dropdown with `"ADMINISTRATOR"`
- Update selectItem label

#### [MODIFY] [CalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/CalendarView.tsx)
- Replace `PENDING_CEO` status config with `PENDING_ADMIN`
- Update label from "Pending CEO" → "Pending Admin"

#### [MODIFY] [UserGuide.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/UserGuide.tsx)
- Replace `"ceo"` tab with `"admin"` tab
- Replace `hasRole("CEO")` → `hasRole("ADMINISTRATOR")`
- Rename `CEOGuide` component → `AdminGuide`
- Update text content to reference "Administrator" instead of "CEO"

---

### Frontend — Components

#### [MODIFY] [StatusBadge.tsx](file:///c:/Apps/Leave%20Tracker/src/components/StatusBadge.tsx)
- Replace `case 'PENDING_CEO':` → `case 'PENDING_ADMIN':`

#### [MODIFY] [FullCalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/components/FullCalendarView.tsx)
- Replace `PENDING_CEO` → `PENDING_ADMIN` in status map and approval logic
- Replace `CEO` role check → `ADMINISTRATOR`

#### [MODIFY] [ApprovalTimeline.tsx](file:///c:/Apps/Leave%20Tracker/src/components/ApprovalTimeline.tsx)
- Replace `PENDING_CEO` → `PENDING_ADMIN` in completed status checks

#### [RENAME] [CEODashboard.tsx → AdminDashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/CEODashboard.tsx)
- Rename file and component
- Replace `PENDING_CEO` → `PENDING_ADMIN`
- Update internal labels (but keep "Chief Executive Officer" on PDF-facing labels)

#### [MODIFY] [PendingReservations.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/PendingReservations.tsx)
- Replace `CEO: 'PENDING_CEO'` → `ADMINISTRATOR: 'PENDING_ADMIN'`

#### [MODIFY] [EmployeeDashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/EmployeeDashboard.tsx)
- Replace `PENDING_CEO` → `PENDING_ADMIN` in status lists

---

### Frontend — Hooks

#### [MODIFY] [useRoleAccess.ts](file:///c:/Apps/Leave%20Tracker/src/hooks/useRoleAccess.ts)
- Rename `isCEO` → `isAdmin`; change check from `'CEO'` → `'ADMINISTRATOR'`
- Replace `'CEO'` in all `hasAnyRole` arrays with `'ADMINISTRATOR'`

---

### Frontend — PDF/Lib

#### [MODIFY] [corporatePdf.ts](file:///c:/Apps/Leave%20Tracker/src/lib/corporatePdf.ts)
- Replace `'CEO'` role references with `'ADMINISTRATOR'` where used for conditional logic
- **Keep "Chief Executive Officer" text** in the PDF template labels (per user requirement)

---

### Sidebar

#### [MODIFY] [Sidebar.tsx](file:///c:/Apps/Leave%20Tracker/src/components/layout/Sidebar.tsx)
- Replace any `'CEO'` role checks with `'ADMINISTRATOR'` (if present)

---

## Verification Plan

### Automated Tests
1. `npx prisma db push --force-reset` — Verify the schema changes apply cleanly
2. `node seed-prod.js` — Re-seed with updated ADMINISTRATOR role (update seed script)
3. Restart server with `npm run dev` — Verify no startup errors
4. Browser test: Login as admin → Navigate to Requests → Verify "Pending Admin" filter works

### Manual Verification
- Login as different roles (Employee, OM, GM, Administrator) and verify the approval flow
- Submit a test leave request and trace it through the full pipeline
- Download a PDF and verify "Chief Executive Officer" label is preserved
- Verify the Calendar view shows correct status labels
