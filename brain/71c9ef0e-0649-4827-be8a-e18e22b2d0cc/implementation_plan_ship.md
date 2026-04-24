# Unified Deployment Script (ship.ps1)

This plan outlines the creation of a 'master' script that simplifies the entire development-to-production lifecycle into a single command.

## User Review Required

> [!NOTE]
> The script will default to including **Database Migrations** (`-MigrateDb`) and will prompt for a commit message if changes are detected.

## Proposed Changes

### [NEW] [ship.ps1](file:///c:/Apps/Leave%20Tracker/ship.ps1)
A PowerShell script that performs the following:
1. **Cleanup**: Automatically removes temporary files and zips.
2. **Git Sync**: 
   - Checks for local changes.
   - Prompts for a commit message.
   - Pushes to GitHub.
3. **Deployment**:
   - Executes `.\deploy-v2.ps1` with passed-through parameters.
   - Defaults to `-MigrateDb` for safety given recent schema changes.

## Verification Plan

### Automated Tests
- Run `.\ship.ps1 -DryRun` to ensure the logic flow works without touching the remote servers.

### Manual Verification
- Verify that Git changes are pushed.
- Verify that the deployment system starts correctly.
