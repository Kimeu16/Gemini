# Administrator Leave Approval Flow — Full Approval Chain

Administrators currently auto-approve their own leave requests (status goes straight to `APPROVED`). This change makes Administrators follow the same multi-level approval chain as regular employees, with the final approval coming from the **other Administrator** (since there are two).

## Current Flow (Administrator)
```
Administrator applies → Auto-APPROVED (self-approved, balance deducted immediately)
```

## Proposed Flow (Administrator)
```
Administrator applies → PENDING_OM → PENDING_GM (or CTO if GM absent) → PENDING_ADMIN (other Administrator approves)
```

This matches the normal employee flow: **OM → GM → Admin**, except the Admin who applied is excluded from the final PENDING_ADMIN approval — only the *other* Administrator can give final approval.

> [!IMPORTANT]
> The CEO step you mentioned is handled by the existing `PENDING_ADMIN` stage. In this system, "CEO" approval is done through the Administrator role (the Administrator downloads the PDF, gets the CEO's manual signature, then clicks confirm). This flow is already built — we just need to stop Administrators from bypassing it.

## Open Questions

> [!IMPORTANT]
> **Self-approval prevention**: Should an Administrator be blocked from approving their **own** leave request at the PENDING_ADMIN stage? Currently, both Administrators can click "Approve" on any PENDING_ADMIN request. I will add a check so an Administrator cannot approve their own request — only the other Administrator can.

## Proposed Changes

### Backend — Leave Controller

#### [MODIFY] [leave.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/leave.controller.ts)

**1. `createLeaveRequest` — Remove admin auto-approve bypass (lines 376-379)**

The fallback logic currently has:
```typescript
if (userRole === 'ADMINISTRATOR') {
    initialStatus = 'APPROVED';
    adminNameRef = employee.user.name;
    adminDateRef = new Date();
}
```
Change to make ADMINISTRATOR start at `PENDING_OM` (same as regular employees):
```typescript
if (userRole === 'ADMINISTRATOR') {
    initialStatus = 'PENDING_OM'; // Administrators follow the normal flow
}
```

**2. `createLeaveRequest` — Remove immediate balance deduction for admin auto-approve (lines 424-435)**

The block that deducts balance on auto-approve will no longer trigger for admin (since status won't be `APPROVED` at creation), but we should also guard against the reservation-conversion edge case. No change needed — the `if (initialStatus === 'APPROVED')` guard already handles this correctly since the reservation conversion is separate.

**3. `adminApproveLeaveRequest` — Prevent self-approval (line ~1208)**

Add a check: if the approving admin is the same employee who submitted the leave request, reject the action with a clear error message.

```typescript
// Prevent admin from approving their own leave request
const requestEmployee = await prisma.employee.findUnique({
    where: { id: leaveRequest.employeeId }
});
if (requestEmployee?.userId === userId) {
    throw new AppError('You cannot approve your own leave request. The other Administrator must approve it.', 403);
}
```

---

### Frontend — Line Manager Dropdown

#### [MODIFY] [Requests.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Requests.tsx)

**1. Line Manager options for Administrator (line ~728-744)**

Currently, Administrators don't see a line manager dropdown (because their requests are auto-approved). Since they now need approval, they should see OM and HOD_PROJECTS in the line manager dropdown, just like regular employees:

```typescript
// For Administrators, show OM / HOD_PROJECTS as line managers (same as employees)
if (user?.role === "ADMINISTRATOR") {
    return (LINE_MANAGER_ROLES as readonly string[]).includes(role);
}
```

**2. Prevent admin from approving own request in the UI (approval button logic)**

Add a check in the approval button rendering logic so the "Approve" button doesn't appear on an admin's own request when status is PENDING_ADMIN.

---

## Summary of Changes

| File | What Changes | Why |
|------|-------------|-----|
| `leave.controller.ts` L376-379 | Admin → `PENDING_OM` instead of `APPROVED` | Force admin through approval chain |
| `leave.controller.ts` L~1219 | Add self-approval guard | Prevent admin from approving own request |
| `Requests.tsx` L728-744 | Show OM/HOD in line manager dropdown for admins | Admin needs to select a line manager |
| `Requests.tsx` approval buttons | Hide approve button for own request | UX guard against self-approval |

## Verification Plan

### Automated Tests
- Build the backend to verify no TypeScript errors
- Run the dev server and test in the browser

### Manual Verification
- Log in as Administrator (Mercy Cheptoo) and create a leave request
- Verify it starts at PENDING_OM (not auto-approved)
- Verify the line manager dropdown appears for the admin
- Log in as the other Administrator and verify they can see and approve the PENDING_ADMIN request
- Verify the same Administrator who applied **cannot** approve their own request
