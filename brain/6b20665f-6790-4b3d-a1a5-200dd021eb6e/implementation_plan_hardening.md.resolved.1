# Hardening Deployment System (v2.2) - Final Specification

This plan implements all 12 points of improvements to turn the Leave Tracker deployment system into a production-hardened pipeline. 

## Proposed Changes

### [Component] [deploy-v2.ps1](file:///c:/Apps/Leave%20Tracker/deploy-v2.ps1)

#### 1. Security & Identity (High)
- [ ] **Remove Hardcoded User**: Throw error if `DEPLOY_VM_USER` is missing.
- [ ] **DryRun UX**: Skip credential collection if `-DryRun` is set.
- [ ] **Progress Scope**: Re-scope `$ProgressPreference` to local only to avoid silencing remote error reporting.

#### 2. Concurrency & Integrity (High/Medium)
- [ ] **Deployment Locking**: Implement `C:\deploy.lock` logic on remote VMs to prevent concurrent runs.
- [ ] **SCP Integrity**: Use `Get-FileHash` (SHA256) locally and remotely to verify ZIP archives after transfer.
- [ ] **Port Guard**: Explicitly kill process on `$TestPort` (5001) before pre-flight to prevent orphaned leaks.

#### 3. Operational Excellence (Medium)
- [ ] **Versioned Releases**: Move from `leave-tracker`/`prev` to a `C:\releases\vYYYYMMDD-HHMM` structure.
    - [ ] Use `New-Item -ItemType Junction` to map `C:\leave-tracker` to the active version.
    - [ ] This provides an audit trail of previous releases on the disk.
- [ ] **Manual Rollback Mode**: Implement `-Mode Rollback` flag.
    - [ ] Skips build/upload.
    - [ ] Prompts for which version to revert to (or defaults to the previous one in the `releases` folder).
    - [ ] Swaps the junction point and restarts the service.
- [ ] **Scheduled Task Logic**: Check if the task exists; if yes, only update `Set-ScheduledTask` instead of `Register-ScheduledTask` to preserve run history.

#### 4. Logging & Performance (Minor)
- [ ] **Structured Logging**: Implement `Write-Log` function that tees to `C:\deploy.log` with `[TIMESTAMP] [LEVEL] MESSAGE` format.
- [ ] **Latency Removal**: Remove the fixed 6s sleep. Let the 3-retry health check handle startup time.
- [ ] **Metrics**: Add "Build Time", "Transfer Time", and "Cutover Time" to both the console summary and the `deploy-manifest.json`.

## Versioned Directory Structure
```
C:\
  releases\
    v20260409-1000\      <-- Current (active)
    v20260408-0900\      <-- Previous
  leave-tracker          <-- Junction/Symlink pointing to releases\v20260409-1000
  deploy.log             <-- Persistent history
  deploy.lock            <-- Safety guard
```

## Verification Plan

### Automated Tests (via -DryRun)
- [ ] Verify manifest includes new metrics fields.
- [ ] Verify script throws correctly when `DEPLOY_VM_USER` is missing.

### Manual Verification (Post-Deploy)
- [ ] **Audit Trail**: Confirm `C:\releases` contains the new folder and `C:\leave-tracker` is a junction pointing to it.
- [ ] **Locking**: Try starting a second deploy while the first is running and verify it aborts.
- [ ] **Rollback**: Run `.\deploy-v2.ps1 -Mode Rollback` and verify it restores the junction to the previous folder in `< 2 seconds`.
