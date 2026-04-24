# Bulk Upload with Custom Balances & Deferred Emails

## Backend
- [x] Update `createEmployeeWithUserSchema` to accept `annualLeave`, `sickLeave`, `suppressEmail`
- [x] Modify `processSingleEmployee()` to use custom balances and respect email suppression
- [x] Add `sendWelcomeEmails` controller endpoint
- [x] Add `getPendingWelcomeCount` controller endpoint
- [x] Add routes `POST /employees/send-welcome-emails` and `GET /employees/pending-welcome-count`

## Frontend
- [x] Update Excel parsing to read `annual_leave` / `sick_leave` columns
- [x] Add "Suppress Emails" checkbox to Bulk Import dialog (checked by default)
- [x] Pass `suppressEmail` + custom balances to API
- [x] Add "Send Welcome Emails" button with pending count badge
- [x] Add confirmation dialog for sending welcome emails
- [x] Fetch pending welcome count on page load and after import
- [x] TypeScript compilation verified (frontend ✅, backend ✅ — pre-existing errors in other files only)
