# Zero-Downtime Deployment Script Restructure

## Problem Statement

The current `deploy-posh.ps1` has two critical issues:

1. **Missing files in deployment** — The staging step cherry-picks only 5 items (`dist/`, `prisma/`, `package.json`, `package-lock.json`, `public/`), missing `prisma.config.ts` and any new files added to the server directory. This is the root cause of "changes not deploying."
2. **Service downtime** — The script stops the backend service, then runs `npm ci` (~20s) and `npx prisma generate` (~5s) before restarting. That's 25+ seconds of downtime per deploy, plus the `Move-Item` backup frequently fails because Node.js has files locked.

## Root Cause Analysis

### Why files are missing
Current staging logic (lines 226-231):
```powershell
Copy-Item "server\dist"          → staging\dist           ✅
Copy-Item "server\prisma"        → staging\prisma         ✅
Copy-Item "server\package.json"  → staging\package.json   ✅
Copy-Item "server\package-lock.json" → staging\package-lock.json ✅
Copy-Item "public"               → staging\public         ✅
# MISSING: prisma.config.ts, nodemon.json, tsconfig.json, .env.production, any new files
```

### Why downtime occurs
```
Stop service → npm ci (20s) → prisma generate (5s) → Start service
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
              ~25 seconds of TOTAL DOWNTIME
```

## Proposed Changes

### [NEW] [deploy-v2.ps1](file:///c:/Apps/Leave Tracker/deploy-v2.ps1)

A completely restructured deployment script that keeps the existing professional standards (dry-run, guards, health checks, rollback backups) while fixing both issues with:

#### 1. Complete File Sync (fixes missing changes)
Instead of cherry-picking individual files, the new script will:
- Stage **all production-necessary** backend files using a whitelist of required items: `dist/`, `prisma/`, `public/`, `package.json`, `package-lock.json`, `prisma.config.ts`, `nodemon.json`
- Add a `$BackendExtraFiles` array parameter that makes it easy to add new files without editing the script
- Auto-detect and warn about any new non-excluded files in `server/` that aren't being staged

#### 2. Blue-Green Zero-Downtime Deployment (fixes service outage)

**Frontend (already near-zero-downtime):** Nginx file swap + `reload` is atomic — no change needed.

**Backend (new blue-green approach):**
```
CURRENT STATE: C:\leave-tracker (port 5000, RUNNING, serving users)

1. Deploy to C:\leave-tracker-next       ← new directory
2. npm ci in C:\leave-tracker-next       ← while OLD is still running
3. prisma generate in C:\leave-tracker-next
4. Health-test C:\leave-tracker-next on temp port 5001
5. ─── CUTOVER (< 3 seconds) ───
   a. Stop old service (port 5000)
   b. Rename: C:\leave-tracker → C:\leave-tracker-prev
   c. Rename: C:\leave-tracker-next → C:\leave-tracker
   d. Start new service (port 5000)
6. Health check production port 5000
7. Clean up C:\leave-tracker-prev
```

The heavy work (npm ci, prisma generate) happens **while the old version is still serving users**. The actual cutover window is just a stop → rename → start cycle (~2-3 seconds).

#### 3. Automatic Rollback on Failure
If the new version fails health checks after cutover:
```
Rename C:\leave-tracker → C:\leave-tracker-failed
Rename C:\leave-tracker-prev → C:\leave-tracker
Restart old service
```

#### Key Features Preserved from Current Script
- ✅ `Posh-SSH` based remote execution
- ✅ `-DryRun` mode (simulation without remote changes)
- ✅ `-SkipConfirm` mode (CI/CD friendly)
- ✅ `-MigrateDb` flag with triple confirmation
- ✅ Interactive deployment guards ("Have you tested locally?")
- ✅ Comprehensive health checks (port listener, `/health` endpoint, frontend root, API proxy)
- ✅ Color-coded step-by-step output

#### New Features
- 🆕 `-WhatChanged` flag: Shows a diff summary of what will be deployed vs what's currently live
- 🆕 Blue-green cutover with <3s service gap
- 🆕 Automatic rollback on health check failure
- 🆕 Pre-flight validation: tests SSH connectivity before starting builds
- 🆕 Deployment manifest: writes a `deploy-manifest.json` to the remote with timestamp, git commit hash, and deployed file list

## Open Questions

> [!IMPORTANT]
> The current temp port for blue-green health testing will be **5001**. Is there any firewall rule or service on the backend VM that would conflict with port 5001?

> [!NOTE]
> The old script will be preserved as `deploy-posh.ps1` (untouched). The new script will be `deploy-v2.ps1`. Once validated, you can rename or alias it.

## Verification Plan

### Automated Tests
1. Run `.\deploy-v2.ps1 -DryRun` to verify local build + staging logic works correctly without touching VMs
2. Verify the staged backend zip contains `prisma.config.ts` and all required files
3. Full deployment to production with health check validation

### Manual Verification  
1. After deploy, confirm the frontend at `http://10.172.19.16` reflects latest changes  
2. Confirm the backend at `http://10.172.19.15:5000/health` returns 200
3. Test a user workflow (e.g., login, view dashboard) to confirm no regressions
