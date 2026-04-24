# Implementation Plan - Standardizing Sick Leave Balances

The user has identified that all employees currently have `0` sick leave days. This plan outlines the steps to batch update all existing users to 10 days and ensure 10 days remains the standard default for all future additions.

## Proposed Changes

### [Database]

#### [NEW] [update-sick-balances.ts](file:///c:/Apps/Leave%20Tracker/server/scratch/update-sick-balances.ts)
- Create a one-time script to iterate through all `Employee` records.
- Parse the `leaveBalances` JSON string.
- Update the `sick` field to `10`.
- Save the updated JSON back to the database.

### [Server]

#### [MODIFY] [constants.ts](file:///c:/Apps/Leave%20Tracker/server/src/utils/constants.ts)
- (Verified) `APP_CONSTANTS.DEFAULT_LEAVE_BALANCES.SICK` is already set to `10`.

#### [MODIFY] [employee.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/employee.controller.ts)
- Review the `createEmployeeWithUserInternal` function to ensure that if `sickLeave` is explicitly passed as `0` or empty, it still defaults to `10` unless specifically intended (though for this system, 10 is the global minimum).

## Verification Plan

### Automated Tests
- Run the update script and log the number of modified records.
- Fetch a sample set of users via Prisma Studio or a temporary log to verify the `leaveBalances` field.

### Manual Verification
- Log in as an administrator.
- Navigate to the **Employees** page.
- Verify that the "Sick Leave Balance" column shows `10` for users.
- Check a user's **Profile** to see the 10-day sick leave allocation.
