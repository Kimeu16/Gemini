# Implementation Plan: User Refresh and Display Fix

This plan addresses the need to re-standardize the primary staff records (Anthony, Joram, Dedan) and ensures all employees are visible in the application UI.

## Proposed Changes

### Database Cleanup \u0026 Re-Import

#### [NEW] [refresh-skipped-users.ts](file:///c:/Apps/Leave%20Tracker/server/refresh-skipped-users.ts)
- Create a script that:
  - Deletes the `User` and associated `Employee` records for:
    - `kimeu.anthony@alandick.co.ke`
    - `joram.n@adcea.com`
    - `dedan.ongara@alandick.co.ke`
  - Re-runs the logic from the bulk importer for just these 3 emails from the CSV.
  - This ensures they have the correct standardized phone numbers and leave balances as defined in the master CSV.

### UI Display Fix

#### [MODIFY] [constants.ts](file:///c:/Apps/Leave%20Tracker/server/src/utils/constants.ts)
- Increase `PAGINATION.DEFAULT_LIMIT` from `10` to `100`.
- This ensures that for the current team size of ~60, all users appear immediately without needing pagination controls (which may be missing or hard to find in the current UI).

## Verification Plan

### Automated Tests
- Run `refresh-skipped-users.ts` and verify the output logs confirm deletion and re-creation.
- Verify `getAllEmployees` API response now returns `limit: 100` and `results: 56`.

### Manual Verification
- Log in to the application and verify that the "Employees" page now shows the full list (scrollable) instead of being cut off at 10.
- Verify that Anthony Kimeu's profile is updated with the CSV details.
