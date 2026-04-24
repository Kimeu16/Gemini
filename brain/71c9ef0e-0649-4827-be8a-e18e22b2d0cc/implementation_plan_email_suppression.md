# Implementation Plan: Email Suppression for Employee Creation

Ensure that welcome emails can be suppressed during both bulk uploads and manual employee creation, allowing administrators to verify data before notifying staff.

## Proposed Changes

### Backend

#### [MODIFY] [employee.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/employee.controller.ts)
- Update `createEmployeeWithUser` to check the `suppressEmail` flag from the validated request body.
- Wrap the email sending logic in a conditional block that honors this flag.

### Frontend

#### [MODIFY] [Employees.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Employees.tsx)
- Add a new state variable `suppressManualEmail` (defaulting to `false`, or maybe `true` if the user prefers consistency with bulk).
- Add a "Suppress Welcome Email" checkbox/toggle to the "Add New Employee" dialog.
- Update `handleCreateEmployee` to pass the `suppressEmail` flag in the API mutation.

## Verification Plan

### Automated Tests
- Perform a manual employee creation via the UI with the checkbox **checked** and verify (via server logs) that the email was suppressed.
- Perform a manual employee creation via the UI with the checkbox **unchecked** and verify that the email was sent.

### Manual Verification
1. Open the "Add New Employee" dialog.
2. Verify the new checkbox is visible and functional.
3. Verify that Bulk Import still suppresses emails as it currently does.
