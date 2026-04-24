# Implementation Plan: Reservation Approval StatCard

Add a summary "Reservation Approvals" stat card to the top bar of the OM, GM, and CEO dashboards, positioned next to the "Total Staff" card.

## Proposed Changes

### [MODIFY] [stats.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/stats.controller.ts)
Update `getOverviewStats` to include pending reservation counts by status.
- Add a new query to `Promise.all` that groups `reservation` by `status` where status is in `PENDING_HOD_PROJECTS`, `PENDING_OM`, `PENDING_GM`, or `PENDING_CEO`.
- Extract these counts and include them in the JSON response (e.g., `pendingOMReservations`, `pendingGMReservations`, etc.).

### [MODIFY] Dashboard Components
Update [OMDashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/OMDashboard.tsx), [GMDashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/GMDashboard.tsx), and [CEODashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/CEODashboard.tsx).
- Adjust the `statsLoading` skeleton grid to show 5 cards instead of 4.
- Update the main `grid` container for `StatCard` components from `lg:grid-cols-4` to `xl:grid-cols-5` (or similar responsive grid to handle 5 cards).
- Add a new `StatCard`:
    - **Icon**: `CalendarClock`
    - **Label**: "Reservation Approvals"
    - **Value**: The count of pending reservations for the current role.
    - **Gradient**: `gradient-primary` or similar.
    - **Click Action**: Navigate to `/calendar` (where the deep-linking logic is already implemented).

## Verification Plan

### Automated Tests/Checks
- Check the `/stats/overview` API response to ensure new fields are present.
- Verify the dashboard layout handles 5 cards correctly on desktop and mobile.

### Manual Verification
- Log in as OM, GM, and CEO.
- Verify that the new StatCard displays the correct number of pending reservations.
- Verify that clicking the card navigates correctly.
