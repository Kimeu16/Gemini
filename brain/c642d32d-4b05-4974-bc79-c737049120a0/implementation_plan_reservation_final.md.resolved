# Implementation Plan - Fix Reservation Conflict & Implement Notifications

This plan addresses the `Unique constraint failed` error on SQL Server and implements the requested notification/approval cycle for reservations.

## Resolved Issue: 500 Internal Server Error

The error was caused by the `@unique` constraint on the `leaveRequestId` field in the `Reservation` model. On SQL Server, a unique index only allows one `NULL` value. Since most reservations start with a `null` leave request ID, subsequent creations were failing.

## Proposed Changes

### Database Schema Fix

#### [MODIFY] [schema.prisma](file:///c:/Apps/Leave%20Tracker/server/prisma/schema.prisma)
- Remove `@unique` from `leaveRequestId` in the `Reservation` model.
- Update `Reservation` status options to include `PENDING`, `APPROVED`, `REJECTED`.
- Add `approverId` and `handledAt` to `Reservation`.

### Backend - Notification & Approval Logic

#### [MODIFY] [reservation.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/reservation.controller.ts)
- Update `createReservation`: Store as `PENDING` and trigger "New Reservation" notifications.
- Add `approveReservation(id)` and `rejectReservation(id)` endpoints.
- Integrate `emailService` for both requesters and approvers.

### Backend - Email Templates

#### [MODIFY] [email.service.ts](file:///c:/Apps/Leave%20Tracker/server/src/services/email.service.ts)
- Add templates for:
    - **Reservation Approval Request** (Sent to Managers).
    - **Reservation Decision Notice** (Sent to Employees).

## Verification Plan

### Automated Tests
- `prisma db push` to verify schema correction.
- Manual POST to `/api/reservations` to confirm multiple reservations can now exist (solving the 500 error).

### Manual Verification
- Verify that managers receive an email when a reservation is made.
- Verify that employees receive a notification when their reservation is approved or rejected.
