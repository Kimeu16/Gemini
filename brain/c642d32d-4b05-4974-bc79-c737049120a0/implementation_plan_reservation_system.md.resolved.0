# Implementation Plan: Reserve Leave Days Feature

Implement an informal date-holding system that allows employees to plan their leave ahead of time without triggering the full corporate approval workflow immediately.

## User Review Required

> [!IMPORTANT]
> This feature introduces a new `Reservation` model to the database. A production migration (`prisma migrate deploy`) will be required after development.

> [!NOTE]
> Visibility is restricted to **Department Members** and **Approvers** (HOD, OM, GM, CEO) to ensure privacy while allowing for effective team scheduling.

## Proposed Changes

### [Backend] Data & Logic Layer

#### [MODIFY] [schema.prisma](file:///c:/Apps/Leave%20Tracker/server/prisma/schema.prisma)
- Add the `Reservation` model with fields for `employeeId`, `startDate`, `endDate`, `leaveType`, and `status` (RESERVED, CONVERTED, CANCELLED, EXPIRED).
- Establish a relationship between `Reservation` and `Employee`.

#### [NEW] [reservation.routes.ts](file:///c:/Apps/Leave%20Tracker/server/src/routes/reservation.routes.ts)
- Define endpoints for:
    - `POST /api/reservations`: Create a new reservation.
    - `GET /api/reservations/my`: Fetch the current user's reservations.
    - `GET /api/reservations/department`: Fetch reservations within the user's department.
    - `POST /api/reservations/:id/convert`: Initiate conversion to a `LeaveRequest`.
    - `POST /api/reservations/:id/cancel`: Cancel a reservation.

#### [NEW] [reservation.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/reservation.controller.ts)
- Implement logic for date range validation (ranges only, as requested).
- Conflict detection: Show warnings if other reservations overlap, but do not block.

### [Frontend] UI & Visibility

#### [MODIFY] [FullCalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/components/FullCalendarView.tsx)
-   Integrate fetching for both `leaves` and `reservations`.
-   **Visual Treatment**: 
    -   `RESERVED`: Render with dashed borders and 60% opacity.
    -   Update Tooltip to include a "Convert to Application" button for the user's own reservations.

#### [NEW] [ReservationModal.tsx](file:///c:/Apps/Leave%20Tracker/src/components/ReservationModal.tsx)
-   A simplified form (Dates + Leave Type) for quick planning.

#### [MODIFY] [History.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/MyHistory.tsx) (Assuming this is the history page)
-   Add a "Planning/Reservations" tab to track tentative dates and their conversion status.

## Verification Plan

### Automated Tests
- Verify that a `Reservation` does not impact the `LeaveBalance` until it is successfully converted and approved.
- Verify that users cannot see reservations from other departments (unless they are approvers).

### Manual Verification
- Perform the full flow: **Reserve** (Dashed bubble appears) -> **Convert** (Picks up dates to Leave Form) -> **Submit** (Formal process starts).
