# Implementation Plan: Resolve Nginx Reload Access Denied

Resolve the `nginx: [error] OpenEvent("Global\ngx_reload_4196") failed (5: Access is denied)` error encountered during deployment. This occurs because the deployment user does not have permissions to signal the existing Nginx process for a graceful reload.

## User Review Required

> [!IMPORTANT]
> This change will switch from a **Graceful Reload** (`-s reload`) to a **Forceful Restart** (Stop and Start). While slightly more disruptive (milliseconds of downtime), it is the most reliable way to ensure new configurations are applied when permission levels are restricted.

## Proposed Changes

### Deployment Script

#### [MODIFY] [deploy-posh.ps1](file:///c:/Apps/Leave%20Tracker/deploy-posh.ps1)
- Update the Nginx deployment logic (lines 287-291) to:
  1. Always perform a syntax check (`nginx -t`).
  2. Kill all existing `nginx` processes using `Stop-Process -Force`.
  3. Start a new Nginx process.
- This mirrors the logic found in the `watchdog-nginx.ps1` which is already running successfully on the VMs.

## Open Questions

- None. The forceful restart is a standard workaround for Nginx on Windows in restricted environments.

## Verification Plan

### Automated Tests
- N/A (Requires remote execution)

### Manual Verification
1. Request the user to run `.\deploy-posh.ps1` again.
2. Verify that Step [4/7] completes without the "Access Denied" error.
