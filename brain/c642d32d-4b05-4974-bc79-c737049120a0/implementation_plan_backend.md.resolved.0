# Backend Script & Log Cleanup

Proposing the removal of legacy testing scripts, temporary log files, and local database dumps in the `server` directory that are no longer needed.

## User Review Required

> [!important]
> I am proposing to delete several database dump files (`.sql`, `.dump`) and one-off testing scripts (`.js`, `.ts`). Please ensure you have remote backups of your current database state before I proceed.

## Proposed Changes

### Server Directory Cleanup

#### [DELETE] Legacy Testing & Diagnostic Scripts
- `check-audit-schema.js`
- `check-collation.js`
- `check-columns.js`
- `check-data.js`
- `check-employee-balances.js`
- `check-logs-schema.js`
- `check-prod-db.js`
- `check-schema-names.js`
- `check-users-snake.js`
- `check_all_users.js`
- `check_balances.js`
- `debug_stats.js`
- `diag-db.js`
- `diag_case.js`
- `diag_login.js`
- `diag_om.js`
- `find_test_users.js`
- `fix_om_name.js`
- `inspect-om.js`
- `scan-dbs.js`
- `setup_test_users.js`
- `test-app-login.js`
- `test-conn.js`
- `test-email-prod.js`
- `test-login-crash.js`
- `test-prisma-v7.js`
- `verify-pwd.js`
- `verify_hod_flow.js`
- `temp-migrate.js`

#### [DELETE] Database Dumps & Backups
- `leave_tracker_backup.dump`
- `server/backups/daily_backup_2025-12-05.sql`
- `server/backups/leave_tracker_backup_2025-12-05_0717.sql`

#### [DELETE] Log Files & Temporary Outputs
- `server_startup.log`
- `temp.log`
- `temp2.log`
- `temp-migration.log`
- `build_errors.txt`
- `test_output.txt`
- `balances_output.json`

## Verification Plan

### Manual Verification
- Ensure the server still starts and connects to the database (`npm run dev` in server).
- Verify that the core API routes (Login, Leave Requests) still function correctly.
