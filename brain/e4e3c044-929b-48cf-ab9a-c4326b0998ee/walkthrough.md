# Walkthrough: Administrator Leave Approval Flow

## What Changed

Administrators previously auto-approved their own leave requests (status went straight to `APPROVED`). Now they follow the exact same approval chain as every other employee:

```
OM → GM (or CTO if GM absent) → Other Administrator
```

## Changes Made

### Backend — [leave.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/leave.controller.ts)

**1. Removed admin auto-approve bypass (line ~374)**

render_diffs(file:///c:/Apps/Leave%20Tracker/server/src/controllers/leave.controller.ts)

- Previously: `if (userRole === 'ADMINISTRATOR') { initialStatus = 'APPROVED'; ... }`
- Now: Administrators fall through to `initialStatus = 'PENDING_OM'` like regular employees
- The immediate balance deduction on creation no longer fires (balance is deducted at final admin approval instead)

**2. Added self-approval guard (line ~1228)**

- New check in `adminApproveLeaveRequest`: if the employee who submitted the request is the same user trying to approve it, the request is rejected with HTTP 403
- Error message: *"You cannot approve your own leave request. The other Administrator must approve it."*

### Frontend — [Requests.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Requests.tsx)

render_diffs(file:///c:/Apps/Leave%20Tracker/src/pages/Requests.tsx)

**1. Line Manager dropdown for admins (line ~728)**

- Added comment clarifying administrators follow the same flow
- No code logic change needed — the existing `LINE_MANAGER_ROLES` filter already covers admins since they weren't matching the `OPERATIONS_MANAGER`/`HOD_PROJECTS` special case

**2. Self-approval guard on UI buttons (lines ~1732, ~1762, ~1935, ~1949)**

- All 4 PENDING_ADMIN button blocks (approve + reject in both card and table views) now include `user?.employee?.id !== request.employeeId`
- An admin sees approve/reject buttons only for **other employees'** requests, not their own

## What Was Tested

- ✅ Frontend TypeScript compilation — clean (0 new errors)
- ✅ Backend TypeScript compilation — clean (only pre-existing errors unrelated to these changes)
- ✅ Backend self-approval guard in controller prevents API-level self-approval
- ✅ Frontend button guards prevent UI-level self-approval

## How the Flow Works Now

| Step | Who Approves | Status Transition |
|------|-------------|------------------|
| 1. Admin submits request | — | → `PENDING_OM` |
| 2. Operations Manager | OM verifies | → `PENDING_GM` |
| 3. General Manager (or CTO if GM absent) | GM endorses | → `PENDING_ADMIN` |
| 4. **Other** Administrator | Downloads PDF for CEO signature, then confirms | → `APPROVED` |
