# Deployment Script Enhancement & Execution Plan

Upgrading `deploy-posh.ps1` with professional features and executing the final production push.

## User Review Required

> [!IMPORTANT]
> The **Rollback Strategy** will create a backup folder (`.rollback`) on the production VMs before every deployment. This consumes extra disk space until the next deployment overwrites it.

## Proposed Changes

### Deployment Script Enhancements

#### [MODIFY] [deploy-posh.ps1](file:///c:/Apps/Leave%20Tracker/deploy-posh.ps1)
- **Documentation**: Add formal PowerShell Comment-Based Help at the top.
- **Dry Run**:
    - Add `[switch]$DryRun` to parameters.
    - Wrap all destructive remote actions (SCP, directory deletions, extraction, and service restarts) in `if (-not $DryRun)` blocks.
- **Rollback/Backup**:
    - Add a `Backup-RemoteDirectory` step before extraction.
    - Previous versions will be stored in `C:\leave-tracker.old` or similar.

### Final Execution

1. **Dry Run Simulation**:
   ```powershell
   .\deploy-posh.ps1 -DryRun
   ```
2. **Production Deployment**:
   ```powershell
   .\deploy-posh.ps1
   ```

## Verification Plan

### Automated Tests
- Run `powershell -File .\deploy-posh.ps1 -DryRun` to verify that no actual changes are made and the script logic flows correctly.

### Manual Verification
- Check the VM file system (via `probe-vms.ps1` or similar) after deployment to ensure the `.old` backup folders exist.
