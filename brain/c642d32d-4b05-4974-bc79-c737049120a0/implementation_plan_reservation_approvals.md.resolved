# Implementation Plan: Pending Reservation Approvals Dashboard Integration

The goal is to provide managers (OM, GM, CEO, HOD Projects) with a direct way to view and approve reservation requests from their dashboards. Clicking a pending reservation will navigate to the Calendar, jump to the correct date, and automatically open the approval modal.

## Proposed Changes

### [NEW] [PendingReservations.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/PendingReservations.tsx)
Create a reusable component to display pending reservations for the current user's role.
- Fetch reservations using the existing `/reservations/department` endpoint (which returns all for managers).
- Filter reservations based on the user's current role and the corresponding status (`PENDING_OM`, `PENDING_GM`, etc.).
- Render a list of pending reservations with employee name, dates, and a "Review" button.

### [MODIFY] Dashboard Pages
Integrate the `PendingReservations` component into:
- [OMDashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/OMDashboard.tsx)
- [GMDashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/GMDashboard.tsx)
- [CEODashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/CEODashboard.tsx)

### [MODIFY] [CalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/CalendarView.tsx)
- Add `useSearchParams` to detect a `reservationId` in the URL.
- Pass the `reservationId` as a prop to `FullCalendarViewComponent`.

### [MODIFY] [FullCalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/components/FullCalendarView.tsx)
- Add a new prop `initialEventId`.
- Implement a `useEffect` that:
    1. Waits for the `events` to be populated.
    2. Finds the event matching `initialEventId`.
    3. Triggers `setSelectedEvent(event)`.
    4. Uses the Calendar API (`calendarApi.gotoDate(event.start)`) to jump to the relevant month/day.

## Verification Plan

### Automated Tests/Checks
- Navigate to the dashboard as an OM with pending reservations.
- Verify the "Pending Reservations" card appears and displays the correct items.
- Click a reservation and verify it redirects to `/calendar?reservationId=xxx`.
- Verify the calendar jumps to the correct month and the approval modal is automatically opened.

### Manual Verification
- Test across different roles (OM, GM, CEO) to ensure filtering logic works correctly for each stage of the approval chain.
- Verify that "Approve" and "Reject" buttons in the modal work as expected when opened via this new flow.
