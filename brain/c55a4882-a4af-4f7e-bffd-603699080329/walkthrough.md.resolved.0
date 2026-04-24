# Walkthrough: Bulk Upload with Custom Balances & Deferred Emails

## Summary

Added support for a one-time employee migration via bulk upload with **custom leave balances** and **deferred welcome emails**.

## Changes Made

### Backend

#### [employee.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/employee.controller.ts)

**Schema changes** (lines 40-54):
- Added `annualLeave` (optional int) — custom annual leave balance
- Added `sickLeave` (optional int) — custom sick leave balance
- Added `suppressEmail` (optional boolean) — skip welcome email

**`processSingleEmployee()` changes** (lines 377-455):
- Uses `data.annualLeave` if provided, otherwise falls back to schedule-based defaults (24 or 26)
- Uses `data.sickLeave` if provided, otherwise defaults to 10
- Only sends welcome email when `suppressEmail` is `false` or undefined

**New endpoints** (lines 524-628):
- `sendWelcomeEmails` — finds all `emailVerified=false` active users, sends welcome email to each, logs the batch action
- `getPendingWelcomeCount` — returns count of users pending welcome emails

#### [employee.routes.ts](file:///c:/Apps/Leave%20Tracker/server/src/routes/employee.routes.ts)

- Added `GET /employees/pending-welcome-count` (OM/CEO only)
- Added `POST /employees/send-welcome-emails` (OM/CEO only)
- Routes placed before `/:id` to avoid param conflict

---

### Frontend

#### [Employees.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Employees.tsx)

**State additions:**
- `suppressEmails` — controls email suppression checkbox (defaults to `true`)
- `showWelcomeConfirm`, `isSendingWelcome`, `pendingWelcomeCount` — welcome email dialog state

**Excel parsing updates:**
- Now reads `annual_leave` / `sick_leave` columns from Excel (supports variations: `annualleave`, `annual leave`)
- Passes `suppressEmail`, `annualLeave`, `sickLeave` to the API for each row

**New UI elements:**
- **"Suppress Welcome Emails" checkbox** in the Bulk Import dialog (checked by default, with helper text)
- **"Send Welcome Emails" button** in the page header (only visible for OM/CEO when pending count > 0)
- **Confirmation dialog** before sending, showing the pending employee count

**Data fetching:**
- `fetchPendingWelcomeCount()` runs on mount (for OM/CEO) and refreshes after each bulk import

## Verification

- ✅ Frontend TypeScript compilation — clean (exit code 0)
- ✅ Backend TypeScript compilation — clean for modified files (5 pre-existing errors in unrelated files)

## Your Excel Template

```
| name | email | department | role | phone | gender | work_schedule | annual_leave | sick_leave |
```

## Workflow

1. **Prepare Excel** — fill in all employees with their current remaining balances
2. **Bulk Import** — "Suppress Welcome Emails" is checked by default
3. **Verify** — check the Employee directory for correct data
4. **Send Emails** — click the green "Send Welcome Emails" button to notify everyone
