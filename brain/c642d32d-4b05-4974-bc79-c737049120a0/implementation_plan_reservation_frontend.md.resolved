# Implementation Plan - Reservation Approval Frontend

This plan outlines the frontend changes required to support the new reservation approval workflow (PENDING → APPROVED/REJECTED), including visual updates in the calendar and a managerial decision interface.

## Proposed Changes

### [API Layer]
#### [MODIFY] [api.ts](file:///c:/Apps/Leave%20Tracker/src/lib/api.ts) (or locally in components)
- Add type definitions and functions for `handleReservation` (PATCH `/reservations/:id/handle`).

### [Calendar Integration]
#### [MODIFY] [CalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/CalendarView.tsx)
- Update `statusConfig` to include styles for `PENDING` and `REJECTED` reservations.
- Ensure `allReservations` query correctly maps the `status` from the backend instead of forcing "RESERVED".

#### [MODIFY] [FullCalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/components/FullCalendarView.tsx)
- Update `eventContent` renderer to visualize `PENDING` reservations (pulsing amber) and `REJECTED` items.
- Enhance the `selectedEvent` detail modal:
    - Detect if the event is a Reservation.
    - If the user is a Manager and the status is `PENDING`, show **Approve** and **Reject** buttons.
    - Implement the `handleReservation` mutation using TanStack Query.
    - Add a "Rejection Reason" field when "Reject" is selected.

## Verification Plan

### Manual Verification
1. **As Employee**:
    - Create a reservation.
    - Verify it appears as "Pending" (Yellow/Amber) in the calendar.
2. **As Manager**:
    - Click on the "Pending" reservation in the calendar.
    - Click "Approve".
    - Verify the status updates to "Reserved" (Blue/Gold).
    - Repeat for "Reject" and verify the reason is logged.
