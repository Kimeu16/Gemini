# Create and Hide Test Users

The user wants to create three specific test users and ensure they are hidden from all employee lists in the system.

## Proposed Changes

### Database & Provisioning

#### [NEW] [provision-test-users.ts](file:///c:/Apps/Leave%20Tracker/server/src/scripts/provision-test-users.ts)
- Create a script to provision the three requested test users:
  1. `ignitionx8@gmail.com` (Employee) - Pass: `0714229988`
  2. `kymeutonnie@gmail.com` (CTO) - Pass: `0714229989`
  3. `kimeu.anthonyy@gmail.com` (GM) - Pass: `0714229990`
- Users will have `isTest: true` and names appended with " (Test Account)".

### Backend Controllers (Filtering)

We need to ensure `isTest: false` is added to all queries that fetch "employees" or "users" for display, statistics, or administrative tasks.

#### [MODIFY] [delegation.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/delegation.controller.ts)
- Update `getBaseWhere` helper to include `isTest: false` so test accounts are never eligible for delegation.

#### [MODIFY] [stats.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/stats.controller.ts)
- Update `getOverviewStats` (line 38) to include `isTest: false` in the total employee count.
- Update `getDepartmentColleaguesOnLeave` (line 258) to include `isTest: false`.
- Update `getDepartments` (line 307) to include `isTest: false`.
- Update `getDepartmentMembers` (line 339) to include `isTest: false`.

#### [MODIFY] [auth.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/auth.controller.ts)
- Update `getGMStatus` (line 393) to include `isTest: false` to ensure test GMs don't trigger status alerts.

#### [MODIFY] [employee.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/employee.controller.ts)
- Update `sendWelcomeEmails` (line 562) to include `isTest: false`.
- Update `getPendingWelcomeCount` (line 631) to include `isTest: false`.

#### [MODIFY] [carryforward.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/carryforward.controller.ts)
- Update `processCarryForward` (line 31) and `previewCarryForward` (line 183) to filter out test users from automated balance processing.

#### [MODIFY] [leave.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/leave.controller.ts)
- Update all `prisma.user.findMany` approver lookups (lines 478, 482, 486, 490, 754, etc.) to include `isTest: false`.

#### [MODIFY] [reservation.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/reservation.controller.ts)
- Update `notifyNextApprover` (line 61) to include `isTest: false` in approver search.

## Verification Plan

### Automated Tests
1. Run the provisioning script: `npx ts-node src/scripts/provision-test-users.ts`
2. Verify users exist in DB with `isTest: true`.

### Manual Verification
1. Log in as an administrator.
2. Check the Employee List page: The test users should NOT appear.
3. Check the Dashboard stats: The total employee count should not include the test users.
4. Try to log in as one of the test users: Should work as expected.
