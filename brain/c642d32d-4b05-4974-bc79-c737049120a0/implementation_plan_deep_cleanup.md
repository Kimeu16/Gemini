# Deep Codebase Cleanup

Proposing the removal of abandoned frontend pages and specialized backend helper scripts that were used during initial setup or one-off data migrations.

## User Review Required

> [!IMPORTANT]
> This cleanup involves removing the `AuthCallback.tsx` page. This was an abandoned Google OAuth integration. If you plan to implement corporate SSO in the future, we should keep this file. Otherwise, it is safe to remove to simplify the routing.

## Proposed Changes

### Frontend Page Cleanup

#### [DELETE] [AuthCallback.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/AuthCallback.tsx)
- Abandoned OAuth callback handler.

#### [MODIFY] [App.tsx](file:///c:/Apps/Leave%20Tracker/src/App.tsx)
- Remove `AuthCallback` import and route.

### Backend Source Cleanup (`server/src`)

#### [DELETE] One-off Scripts & Helpers
- `check-users.ts` (Manual user verification)
- `check_ceo_role.ts` (Manual role verification)
- `check_db.ts` (Manual connection test)
- `create_admin_employee.ts` (Initial setup script)
- `create_user_sql.ts` (SQL generation helper)
- `update-om-email.ts` (One-off data correction)
- `controllers/password-setup.controller.ts.disabled` (Unused disabled controller)
- `scripts/bulk-upload-leave.ts` (One-off migration tool)
- `scripts/leave_balances.csv` (Sample data)
- `scripts/verify-projects-flow.ts` (One-off flow validation)

## Verification Plan

### Automated Tests
- Run `npm run lint` or `tsc --noEmit` to ensure no broken imports.

### Manual Verification
- Verify the Login flow still works (since we are touching `App.tsx` and auth-related paths).
