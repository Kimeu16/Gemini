# Implementation Plan - Reservation Notifications & Emails

Currently, the reservation system tracks "Reserved Days" on the calendar and dashboard but does not trigger any automated communication. This plan outlines the addition of in-app notifications and email alerts to ensure all stakeholders are aware of planning updates.

## User Review Required

> [!IMPORTANT]
> Since reservations are **tentative and non-binding**, these notifications will be **informational only** and will not require any approval actions from managers.

- **Employee Notification**: Should we send an email to the employee for every reservation, or only for conversions/cancellations?
- **Manager Alerts**: Should managers receive emails for reservations, or just in-app notifications to keep their inboxes clean for formal requests?

## Proposed Changes

### Backend - Controller Integration

#### [MODIFY] [reservation.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/reservation.controller.ts)
- Integrate `email.service.ts` to send confirmation emails on reservation creation.
- Add logic to create `Notification` records for department managers (HOD/OM) when a new reservation is made in their team.

### Backend - Email Service

#### [MODIFY] [email.service.ts](file:///c:/Apps/Leave%20Tracker/server/src/services/email.service.ts)
- Add `reservationCreated` template: A professional email confirming the tentative booking.
- Add `reservationCancelled` template: Confirming the removal of a tentative plan.
- Add `reservationConverted` template: Linking the transition from planning to formal application.

### Backend - Notification Flow
- **On Create**:
    - Notification to Employee: "Your dates have been reserved for planning."
    - Notification to Manager: "New planning forecast entry by [Employee Name]."
- **On Convert**:
    - Implicitly handled by the existing Formal Request notifications, but will be updated to acknowledge the reservation source.

## Verification Plan

### Automated Tests
- Trigger `createReservation` via Postman/frontend and verify:
    - Notification entry exists in the `notifications` table.
    - `logger` confirms email delivery attempts.

### Manual Verification
- Log in as an Employee, reserve a day, then log in as an OM and verify the notification appears in the bell icon menu.
