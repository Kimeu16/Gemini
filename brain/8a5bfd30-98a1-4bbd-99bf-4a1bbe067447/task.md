# Consolidate Frontend + Backend onto Single VM

## Infrastructure & Config
- [x] Update `nginx-windows.conf` — proxy to localhost, update root path
- [x] Update `nginx.conf`- [x] Finalize Reversion to 3-VM Architecture
    - [x] Revert `.env.production` (FRONTEND_URL to .16)
    - [x] Revert `nginx-windows.conf` (server_name to .16, proxy_pass to .15)
    - [x] Revert `deploy-v2.ps1` (Split SSH sessions for VM1 and VM2)
    - [x] Revert `ship.ps1` (Cleanup on both hosts)
    - [x] Revert `install-watchdogs.ps1` (Distributed installation)
    - [x] Update `README.md` (3-VM topology)
    - [x] Update `TECHNICAL_DOCS.md` (Split roles)
    - [x] Update `Technical_Guide.html` (Diagrams and IP tables)
    - [x] Update `deployment-guide.html` (Distributed setup steps)
    - [x] Update `docs/OpManager-Guide.html` (Split monitoring)
    - [x] Update `wiki/5-Deployment/Operations-Runbook.md` (Split triage)
    - [x] Update `WATCHDOG-SETUP.md` (Distributed watchdogs)
    - [x] Update `setup-vm.ps1` (Distributed titles/IPs)
    - [x] Update `probe_vms_v2.ps1` (Multi-VM probing)
    - [x] Update `nginx.conf` (Generic config revert)
    - [x] Update `IMPLEMENTATION-SUMMARY.md` (Architecture diagram)te `wiki/5-Deployment/Operations-Runbook.md`
- [x] Update `Technical_Guide.html`

## Verification
- [x] Dry-run build test
