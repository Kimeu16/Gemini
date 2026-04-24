# Implementation Plan: Notifications for Projects Approval Flow

This plan outlines the steps to implement email and in-app notifications for the **Projects Department** approval flow (HOD Projects → GM → CEO).

## Proposed Changes

### [Component] Backend - Email Service

#### [MODIFY] [email.service.ts](file:///c:/Apps/Leave%20Tracker/server/src/services/email.service.ts)
- Update `newLeaveRequest` template to accept an optional `approverRole` parameter (defaulting to "Operations Manager").
- Add `hodApprovedToEmployee` and `hodApprovedToGM` templates to correctly reflect Project department terminology.

### [Component] Backend - Leave Controller

#### [MODIFY] [leave.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/leave.controller.ts)
- **`createLeaveRequest`**: Pass `approverRole: 'Projects HOD'` when the initial status is `PENDING_HOD_PROJECTS`.
- **`hodApproveLeaveRequest`**: 
    - Implement notification logic to inform the **Employee** that their HOD has approved.
    - Implement notification logic to inform all **General Managers** that a request is pending their endorsement.
    - Create in-app notifications for GMs.

## Verification Plan

### Automated Tests
- Run the `verify-projects-flow.ts` script (updated to check for notification records in the DB).
- Use a mock email transporter log check if available.

### Manual Verification
- Create a leave request as a Projects Employee and verify that the HOD receives an email.
- Approve as HOD and verify that the Employee and GMs receive notifications.
