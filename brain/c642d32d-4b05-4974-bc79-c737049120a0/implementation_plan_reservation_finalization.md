# Implementation Plan - Reservation Auto-Finalization

This plan addresses the redundancy in the current workflow where a Reservation approved by all 4 management levels (HOD -> OM -> GM -> CEO) still requires the same 4 managers to approve the leave request application. 

We will modify the sequence so that fully approved Reservations are "Auto-Approved" upon conversion, capturing the required metadata (handover report, etc.) without re-triggering the approval chain.

## User Review Required

> [!IMPORTANT]
> **Approval Inheritance**: The final Leave Request will inherit the approval signatures and dates from the Reservation. This assumes that management approval for a "slot" is legally and procedurally equivalent to approval for the formal application.

## Proposed Changes

### Backend: `server/src/controllers/leave.controller.ts`

#### [MODIFY] [leave.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/leave.controller.ts)
- Add `reservationId` as an optional string to the `createLeaveSchema`.
- In `createLeaveRequest`, if `reservationId` is provided:
    - Verify the reservation exists and has the status `RESERVED`.
    - If valid, set `initialStatus = 'APPROVED'`.
    - Inherit `omApproverId`, `gmApproverId`, `ceoApproverId` and their respective approval dates from the Reservation.
    - This allows the final Leave Request PDF to display the correct management signatures immediately.

### Backend: `server/src/controllers/reservation.controller.ts`

#### [MODIFY] [reservation.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/reservation.controller.ts)
- Update `convertReservation` validation to ensure only `RESERVED` (fully approved) reservations can trigger this auto-approval logic.

### Frontend: `src/pages/Requests.tsx`

#### [MODIFY] [Requests.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Requests.tsx)
- Add a banner: "This period has been pre-approved by Management via Reservation. This application will be finalized immediately."
- Ensure the `reservationId` is sent in the create request payload.
- Auto-refresh the dashboard after submission to show the approved status.

## Verification Plan

### Automated Tests
1. **End-to-End Test**:
    - Login as a user.
    - Create a Reservation.
    - Approval Stage 1-4 (Mock or separate logins as OM, GM, CEO).
    - As user, go to My History -> Reservations.
    - Click "Convert to Application".
    - Fill in "Handover Notes" and "Contact details".
    - Submit.
    - Verify the request status is `APPROVED` immediately.
    - Verify balance deduction in `My Profile`.
