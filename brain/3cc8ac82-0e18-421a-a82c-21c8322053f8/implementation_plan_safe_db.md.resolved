# Safe Database & Infrastructure Implementation Plan

Implementing best practices to guard your Database VM (`10.172.19.33`) against accidental data loss or alteration during application deployments.

## User Review Required

> [!IMPORTANT]
> This plan formalizes the separation between your **App Deployment** and your **Database State**. You will need to explicitly "opt-in" to database schema changes during deployment.

## Proposed Changes

### 1. Deployment Script Upgrades

#### [MODIFY] [deploy-posh.ps1](file:///c:/Apps/Leave%20Tracker/deploy-posh.ps1)
- **Controlled Migrations (Point 4/11)**:
    - Add a `[switch]$MigrateDb` parameter (default: `$false`).
    - Move `npx prisma migrate deploy` into a conditional block—it will **only** run if you explicitly pass `-MigrateDb` to the script.
- **Environment Isolation (Point 1)**:
    - Formalize that the script only interacts with `10.172.19.16` (Frontend) and `10.172.19.15` (Backend).
- **Safety Prompt (Point 5)**:
    - If `-MigrateDb` is set, add a specific interactive prompt: `"WARNING: You are about to modify the database schema on VM3. Proceed? (yes/no)"`.

### 2. Architectural Documentation

#### [MODIFY] [TECHNICAL_DOCS.md](file:///c:/Apps/Leave%20Tracker/TECHNICAL_DOCS.md)
- **Section 9: Database & Infrastructure Safety**:
    - Add a dedicated section documenting the 3-VM split and the "Untouchable DB" principle.
    - Document the recommendation to use restricted SQL users (`leave_app_user` already in use).
    - Outline the backup strategy for VM3.

### 3. Database Security Review

#### [RECOMMENDATION]
- **Point 3 (Restrict Permissions)**: I recommend verifying on Your SQL Server (VM3) that the `leave_app_user` does **not** have the `db_owner` role, but instead has `db_datareader`, `db_datawriter`, and specific `EXECUTE` permissions.

## Verification Plan

### Automated Tests
- Run `.\deploy-posh.ps1 -DryRun` to verify Stage transitions.
- Run `.\deploy-posh.ps1 -DryRun -MigrateDb` to verify the safety prompt triggers correctly.

### Manual Verification
- Confirm that normal deployments (without flags) do not execute any Prisma migration commands.
