# Implementation Plan - Sequential Reservation Approvals

This plan outlines the changes to transition the reservation system from a "blast" notification model to a sequential approval chain, matching the formal leave request hierarchy.

## User Review Required

> [!IMPORTANT]
> **Sequential Flow**: Reservations will now require approval at each level (HOD if applicable, OM, GM, then CEO) before becoming `RESERVED`.
> **Notification Logic**: Approvers will only receive notifications when the request is at their specific stage.

## Proposed Changes

### [Backend]
#### [MODIFY] [reservation.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/reservation.controller.ts)
- **`createReservation`**:
    - Determine `initialStatus`: `PENDING_HOD_PROJECTS` (for Projects) or `PENDING_OM` (others).
    - Send email/notification ONLY to the first-level approver.
- **`handleReservation`**:
    - If `status === 'APPROVED'`:
        - `PENDING_HOD_PROJECTS` -> `PENDING_OM`.
        - `PENDING_OM` -> `PENDING_GM`.
        - `PENDING_GM` -> `PENDING_CEO`.
        - `PENDING_CEO` -> `RESERVED`.
    - If the request moves to a next `PENDING_X` state, notify the corresponding approver(s).
    - If the final stage is reached, notify the employee of the successful reservation.
    - If `status === 'REJECTED'`, stop the chain and notify the employee immediately.

### [Frontend]
#### [MODIFY] [CalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/CalendarView.tsx)
- Update `statusConfig` to map specific legacy leave statuses (`PENDING_OM`, etc.) to reservation-specific styling if needed, or share the same professional amber styling.
- Ensure the legendary legend and stats reflect these new reservation states.

#### [MODIFY] [FullCalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/components/FullCalendarView.tsx)
- Update the click-handler modal to show the **current approval step** for reservations.
- Enable the "Approve/Reject" buttons only for the user whose role matches the current stage.

## Verification Plan

### Manual Verification
1. **As Project Employee**: Create a reservation.
2. **As HOD Projects**: Verify notification received. Approve.
3. **As OM**: Verify notification received. Approve.
4. **As GM**: Verify notification received. Approve.
5. **As CEO**: Verify notification received. Approve.
6. **Result**: Verify the reservation finally turns "RESERVED" (Blue/Gold) and employee gets a confirmation email.
