# Implementation Plan: UI Refinement & Corporate SMTP Transition

This plan covers two main objectives:
1. **Team Directory Filtering**: Hiding the test Operations Manager user ("Anthony Kimeu") from the public directory while maintaining the record for testing.
2. **SMTP Configuration Refactor**: Transitioning the email service from a hardcoded Gmail setup to a flexible, production-ready corporate SMTP configuration.

## Proposed Changes

### 1. Team Directory Filtering (Database & Backend)

#### [MODIFY] [schema.prisma](file:///c:/Apps/Leave%20Tracker/server/prisma/schema.prisma)
- Add `isTest Boolean @default(false) @map("is_test")` to the `User` model.

#### [MODIFY] [employee.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/employee.controller.ts)
- Update `getAllEmployees` and `employee.count` to filter for `isTest: false` by default.

#### [SCRIPT] [mark-test-user.ts](file:///c:/Apps/Leave%20Tracker/server/src/scripts/mark-test-user.ts) [NEW]
- Create a script to mark "Anthony Kimeu" as a test user in the database.

---

### 2. Corporate SMTP Transition (Backend)

#### [MODIFY] [env.ts](file:///c:/Apps/Leave%20Tracker/server/src/config/env.ts)
- Update the environment configuration schema to include:
  - `SMTP_HOST` (e.g., `smtp.gmail.com`)
  - `SMTP_PORT` (e.g., `587`)
  - `SMTP_SECURE` (`true` for 465, `false` for others)
  - `SMTP_USER` (Full company email address)
  - `SMTP_PASS` (App Password)
  - `SMTP_FROM` (Display name or email address)

#### [MODIFY] [email.service.ts](file:///c:/Apps/Leave%20Tracker/server/src/services/email.service.ts)
- Refactor the `transporter` to use a generic SMTP transport instead of the `service: 'gmail'` shortcut.
- This allows for professional Google Workspace, Office 365, or other corporate mail servers.

---

## User Review Required

> [!IMPORTANT]
> **Database Migration**: The `isTest` field addition requires a safe migration. I will use the `/schema-change` protocol.
> [!WARNING]
> **Environment Variables**: You will need to update the `server/.env` file with your company email credentials (SMTP_USER and SMTP_PASS) once the code is deployed.

## Verification Plan

### Automated Tests
- `npm run build` in the backend to verify type safety and Prisma regeneration.

### Manual Verification
- **Directory**: Ensure "Anthony Kimeu" is hidden from the Employees page.
- **Email**: Trigger a "Forgot Password" or "Welcome" email to verify the new SMTP settings are working correctly with the company account.
