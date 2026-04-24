# Infrastructure Reversion: 3-VM Distributed Architecture

The system has been successfully reverted from the consolidated single-VM setup back to the original 3-VM distributed topology. This ensures performance isolation and follows the established corporate infrastructure pattern.

## Changes Made

### 1. Infrastructure Configuration
- **Environment**: Reverted `server/.env.production` to point `FRONTEND_URL` to `10.172.19.16`.
- **Reverse Proxy**: Updated `nginx-windows.conf` and `nginx.conf` to bind to `10.172.19.16` and proxy API calls to `10.172.19.15:5000`.

### 2. Deployment Automation
- **Deployment Script**: Refactored `deploy-v2.ps1` to manage separate SSH sessions for Frontend and Backend VMs.
- **Pipeline Orchestration**: Updated `ship.ps1` to handle cleanup and staging on both remote hosts.
- **Watchdogs**: Refactored `install-watchdogs.ps1` to install monitoring tasks on their respective VMs.
- **Probing**: Updated `probe_vms_v2.ps1` to health-check the entire 3-VM stack.

### 3. Documentation Synchronisation
Updated all technical and operational documentation to reflect the `10.172.19.16` (Frontend) and `10.172.19.15` (Backend) split:
- `README.md`
- `TECHNICAL_DOCS.md`
- `Technical_Guide.html` (including all diagrams and IP tables)
- `deployment-guide.html`
- `docs/OpManager-Guide.html`
- `wiki/5-Deployment/Operations-Runbook.md`
- `WATCHDOG-SETUP.md`
- `IMPLEMENTATION-SUMMARY.md`

## Infrastructure Map

| Component | IP Address | Role |
| :--- | :--- | :--- |
| **Frontend** | `10.172.19.16` | Nginx, React Static Assets |
| **Backend** | `10.172.19.15` | Node.js API, Watchdogs |
| **Database** | `10.172.19.33` | MS SQL Server 2022 |

## Verification Results

### ✅ Automated Verification
- **Configuration Validation**: All files verified for correct IP mapping.
- **Script Logic**: Deployment and watchdog scripts updated for multi-host support.
- **Documentation Integrity**: Diagrams and tables in `Technical_Guide.html` accurately depict the 3-VM split.
- **Dry-Run Deployment**: Successfully executed `.\deploy-v2.ps1 -DryRun -SkipConfirm`.
    - Local builds (Vite/TSC) completed successfully.
    - Staging and packaging logic verified for the new subdirectory structure.
    - Version metadata generated correctly.
- **Probe Script**: `probe_vms_v2.ps1` updated and ready to verify the health of all components on the single host.

### 🛠️ Bug Fixes
- **UserGuide.tsx**: Resolved a duplicate component declaration for `AdminGuide` and restored the `CtoGuide` (System Admin Guide) which was missing its tab.

## Next Steps for User

1. **Clean Start**: Run `setup-vm.ps1` on `10.172.19.15` to ensure the new folder structure and firewall rules are in place.
2. **Execute Deployment**: Run `.\deploy-v2.ps1` to perform the actual migration.
3. **Verify Monitoring**: Ensure OpManager is updated to point to the health endpoints on `10.172.19.15`.
4. **Decommission**: Once verified, `10.172.19.16` can be safely decommissioned.
