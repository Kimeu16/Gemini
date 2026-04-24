# Log Rotation and Retention System

This plan implements an automated log management system to prevent VM disk space exhaustion. It ensures that logs are organized into daily folders and only the most recent 3 days are retained.

## User Review Required

> [!IMPORTANT]
> **Task Scheduler Requirement**: This implementation uses the Windows Task Scheduler to run rotation scripts daily at 23:59. This requires the `SYSTEM` user or high-privilege credentials which are already configured in our deployment scripts.
> 
> **Standardized Paths**: We will move all operational logs to a new standard root at `C:\logs` for easier management.

## Proposed Changes

### Infrastructure (ops/)

#### [NEW] [log-manager.ps1](file:///c:/Apps/Leave%20Tracker/ops/log-manager.ps1)
A new utility script deployed to both VMs that:
- Creates daily folders in `C:\logs\archive\Logs_YYYY-MM-DD`.
- Rotates active logs (`watchdog.log`, `deploy.log`, Nginx logs) into these folders.
- Deletes any `Logs_*` folders older than 3 days.

### Deployment Pipeline

#### [MODIFY] [deploy-v2.ps1](file:///c:/Apps/Leave%20Tracker/deploy-v2.ps1)
- Update the file manifest to include `log-manager.ps1`.
- Add a Step [10b/10] "Configure Log Management" that registers the `log-manager.ps1` as a daily scheduled task on target VMs.
- Update watchdog and log paths to point to the new `C:\logs` hierarchy.

### Operational Scripts

#### [MODIFY] [watchdog-backend.ps1](file:///c:/Apps/Leave%20Tracker/ops/watchdog-backend.ps1)
#### [MODIFY] [watchdog-nginx.ps1](file:///c:/Apps/Leave%20Tracker/ops/watchdog-nginx.ps1)
- Update `$LogPath` to point to `C:\logs\watchdog.log`.

---

## Open Questions

- **Nginx Log Location**: Since Nginx is installed on VM1, can you confirm if it follows the standard path `C:\nginx\logs`?
- **Backend Console Logs**: Currently, the Node.js backend console output (stdout/stderr) is NOT saved to disk. Should we start capturing it into `C:\logs\backend.log` as part of this work?
- **Retention Limit**: You requested a 3-day limit. Is this sufficient for debugging production issues, or would you prefer a slightly longer window (e.g., 5-day) if space allows?

## Verification Plan

### Automated Tests
- Run `.\ops\log-manager.ps1` locally on a test directory to verify the folder creation and the "keep newest 3" logic.
- Verify `schtasks.exe` registration commands in a local dry-run.

### Manual Verification
- After deployment, check Task Scheduler on VM1/VM2 to ensure `LeaveTrackerLogRotation` task is registered and scheduled for 23:59.
