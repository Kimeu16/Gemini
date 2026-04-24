# Bulk Upload with Custom Leave Balances & Deferred Welcome Emails

One-time migration to load all existing employees with their actual leave balances into the system, with emails held back until data is verified.

## User Review Required

> [!IMPORTANT]
> **Workflow**: Upload employees → Verify in the Employee directory → Click "Send Welcome Emails" button to notify everyone at once.

> [!WARNING]
> **Password Policy**: Each employee's phone number will be used as their temporary password. If no phone is provided, the default is `password123`. All users will be forced to change their password on first login.

## Proposed Changes

### Excel Template

Your Excel file should have these columns:

| name | email | department | role | phone | gender | work_schedule | annual_leave | sick_leave |
|------|-------|------------|------|-------|--------|---------------|--------------|------------|
| John Doe | john@co.com | PROJECTS | PROJECT_MANAGER | 0712345678 | MALE | MON_FRI | 12 | 8 |

- **`annual_leave`** *(new, optional)*: The employee's current annual leave balance (e.g., `12`). If blank, defaults to 24 (MON_FRI) or 26 (MON_SAT).
- **`sick_leave`** *(new, optional)*: The employee's current sick leave balance (e.g., `8`). If blank, defaults to 10.

---

### Backend — Employee Controller

#### [MODIFY] [employee.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/employee.controller.ts)

**Changes:**
1. **Add `annualLeave` and `sickLeave` fields** to `createEmployeeWithUserSchema` and `bulkCreateEmployeeSchema` — allows custom balances from the Excel sheet.
2. **Add `suppressEmail` boolean field** to bulk create schema — when `true`, skips sending the welcome email during creation.
3. **Modify `processSingleEmployee()`** to accept and use custom leave balances instead of always using defaults.
4. **Modify `processSingleEmployee()`** to skip welcome email when `suppressEmail` is `true`.
5. **Add new `sendWelcomeEmails` endpoint** — queries all users where `emailVerified = false`, sends the welcome email to each, and marks them as notified. This is your manual trigger after verifying the data.

#### [MODIFY] [employee.routes.ts](file:///c:/Apps/Leave%20Tracker/server/src/routes/employee.routes.ts)

- Add route: `POST /employees/send-welcome-emails` (OM/CEO only)

---

### Frontend — Employees Page

#### [MODIFY] [Employees.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Employees.tsx)

**Changes:**
1. **Update Excel parsing** to read `annual_leave` and `sick_leave` columns and pass them to the API.
2. **Add "Suppress Emails" checkbox** to the Bulk Import dialog (checked by default for safety).
3. **Pass `suppressEmail` flag** to the `/employees/bulk-create` API call.
4. **Add "Send Welcome Emails" button** in the page header (only visible for OM/CEO). This button will:
   - Show a confirmation dialog with the count of pending employees
   - Call `POST /employees/send-welcome-emails`
   - Show a progress/result toast

## Open Questions

> [!IMPORTANT]
> **Leave balance question**: Should the `annual_leave` column in the Excel represent the employee's **remaining** balance right now (e.g., they've used 12 of 24, so you enter `12`)? Or their total entitlement? I'm assuming it's the **remaining balance** — the actual number of days they currently have left.

## Verification Plan

### Manual Verification
1. Upload a small test Excel file (2-3 employees) with custom balances and `suppressEmail` checked
2. Verify in the Employee directory that their leave balances match the Excel values
3. Click "Send Welcome Emails" and confirm emails arrive
4. Then do the full bulk upload of all staff
