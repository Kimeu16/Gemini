# Role-Based Dashboard Visibility for Reserved Days

This plan outlines the integration of "Reserved Days" into the dashboard based on user roles, treating reservations as informational planning data to aid in workforce forecasting.

## User Review Required

> [!IMPORTANT]
> Reservations will remain strictly informational. They will NOT appear in approval queues to ensure they are never confused with binding leave applications.

> [!NOTE]
> For Executives (GM/CEO), the planning forecast will provide a high-level "Corporate Forecast" representing the total number of staff with tentative holds across the entire company.

## Proposed Changes

### Backend (Server)

#### [MODIFY] [stats.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/stats.controller.ts)
- Update `getOverviewStats` to calculate:
    - `myActiveReservationsCount`: Active reservations count for the logged-in user.
    - `planningForecastCount`: Count of staff with active reservations within the user's management scope.

---

### Dashboards (Client)

#### [MODIFY] [EmployeeDashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/EmployeeDashboard.tsx)
- Add a new `StatCard` using the `CalendarClock` icon.
- Label: "My Reserved Dates".
- Value: `stats.myActiveReservationsCount`.

#### [MODIFY] [OMDashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/OMDashboard.tsx)
- Add a new `StatCard` in the top metric row.
- Label: "Staff Planning Forecast".
- Value: `stats.planningForecastCount`.
- Gradient: `gradient-primary`.

#### [MODIFY] [GMDashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/GMDashboard.tsx) & [CEODashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/CEODashboard.tsx)
- Add a "Company Planning" `StatCard`.
- Value: `stats.planningForecastCount`.

## Verification Plan

### Automated Tests
- Verify `/api/stats/overview` returns the new reservation count fields.

### Manual Verification
1. Log in as an **Employee**: Create a reservation and verify it appears on the dashboard.
2. Log in as a **Manager (OM)**: Verify the "Staff Planning Forecast" increments when a departmental employee makes a reservation.
3. Log in as **CEO**: Verify the global planning count includes all reservations company-wide.
