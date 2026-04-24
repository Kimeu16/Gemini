# Implementation Plan: Direct Production Bulk Import

This plan outlines the steps to perform a one-time bulk import of all employees from the cleaned CSV directly into the production database VM.

## Proposed Changes

### Import Script

#### [NEW] [bulk-import-production.ts](file:///c:/Apps/Leave%20Tracker/server/bulk-import-production.ts)
- Create a standalone TypeScript script that:
  - Connects to the database using the production `DATABASE_URL` in `server/.env`.
  - Reads the [Employees.csv](file:///c:/Apps/Leave%20Tracker/LeaveTracker_Employees%20%20-%20Employees.csv) file.
  - Normalizes data (phones, roles, positions).
  - Creates user and employee records in the database.
  - **Suppresses all welcome emails** (logic included but won't be triggered).
  - Logs the result for each row.

## User Confirmation Required

> [!IMPORTANT]
> **Database Target**: I will be performing this upload directly to the database at **10.172.19.33** (the production VM), as configured in your `server/.env` file.
>
> **Email Suppression**: As per our previous discussion, **no welcome emails** will be sent during this process. You can send them later via the application UI.

## Verification Plan

### Automated Tests
- The script will perform a dry-run check (reading CSV) before committing to DB.
- I will verify the final count of users in the database matches the CSV.

### Manual Verification
- After the script runs, you can log in to the system to see the newly populated Team Directory.
