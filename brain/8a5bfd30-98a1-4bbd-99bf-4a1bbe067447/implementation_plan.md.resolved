# Consolidate Frontend + Backend onto Single VM (10.172.19.15)

## Background

**Current Architecture** (3-VM split):
| Component | VM | IP |
|---|---|---|
| Frontend (Nginx + static files) | VM1 | `10.172.19.16` |
| Backend (Node.js + Express) | VM2 | `10.172.19.15` |
| Database (SQL Server 2022) | VM3 | `10.172.19.33` |

**Target Architecture** (2-VM consolidated):
| Component | VM | IP |
|---|---|---|
| Frontend + Backend (same machine) | VM1 | `10.172.19.15` |
| Database (SQL Server 2022) | VM2 | `10.172.19.33` |

On `10.172.19.15`, the folder layout will be:

```
C:\AlanDick-LeaveTracker\
├── app\                        ← Junction (as before, versioned releases)
│   ├── frontend\
│   │   └── dist\               ← React static build
│   └── backend\
│       ├── dist\               ← Compiled Node.js
│       ├── prisma\
│       ├── public\
│       ├── package.json
│       ├── package-lock.json
│       ├── prisma.config.ts
│       └── .env
├── versions\                   ← Versioned releases
├── ops\                        ← Watchdog scripts
├── logs\                       ← Daily log folders
├── metadata\                   ← Deploy locks, logs
└── staging\                    ← Upload landing
```

> [!IMPORTANT]
> **VM `10.172.19.16` will be decommissioned** from Leave Tracker duty. All services move to `10.172.19.15`.

## User Review Required

> [!WARNING]
> **IP Address Change**: The user-facing URL changes from `http://10.172.19.16` → `http://10.172.19.15`. This means:
> - All email links to managers will now point to `http://10.172.19.15/requests/<id>`
> - Any browser bookmarks employees have to `10.172.19.16` will stop working
> - Google OAuth redirect URIs need updating in the Google Cloud Console

> [!IMPORTANT]
> **OpManager Monitoring Links**: You mentioned these should "remain the same." Since the IP is changing, the OpManager monitors will need updated URLs, but the **monitor names and structure** will remain identical. The new URLs will be:
> - `http://10.172.19.15/health` (was `10.172.19.16/health`)
> - `http://10.172.19.15/api/health` (was `10.172.19.16/api/health`)
> - `http://10.172.19.15:5000/health` → becomes `http://localhost:5000/health` (internal only, Nginx proxies it)
> 
> The **3 URL monitors + TCP port monitors + process monitors + task monitors** all stay structurally the same — just the IP changes from `.16` to `.15`.

## Open Questions

> [!IMPORTANT]
> 1. **DNS/Hostname**: Does `ADCERPWEB` (the hostname in current nginx config) resolve to `10.172.19.16` or `10.172.19.15`? If it resolves to `.16`, you may need to update DNS records.
> 2. **VM1 (10.172.19.16) decommission**: Should we create a script to cleanly remove the Leave Tracker services from VM1 (stop nginx, unregister watchdog tasks, etc.)?
> 3. **Nginx on 10.172.19.15**: Is Nginx already installed on `10.172.19.15`? If not, we'll need to install it there.
> 4. **Port 80 firewall**: Is port 80 open on `10.172.19.15`'s firewall? Currently only port 5000 is open.

---

## Proposed Changes

### Nginx Configuration

#### [MODIFY] [nginx-windows.conf](file:///c:/Apps/Leave%20Tracker/nginx-windows.conf)

The big conceptual change: Nginx now proxies to `localhost:5000` instead of `10.172.19.15:5000` since both are on the same machine.

```diff
 server {
     listen 80;
-    server_name 10.172.19.16 ADCERPWEB;
+    server_name 10.172.19.15 ADCERPWEB;

     # Frontend: Serve static files
-    root C:/AlanDick-LeaveTracker/app/dist;
+    root C:/AlanDick-LeaveTracker/app/frontend/dist;

-    # Backend Proxy: API routes → 10.172.19.15
+    # Backend Proxy: API routes → localhost (same VM)
     location /api/ {
-        proxy_pass http://10.172.19.15:5000/api/;
+        proxy_pass http://127.0.0.1:5000/api/;
```

---

### Environment Configuration

#### [MODIFY] [server/.env.production](file:///c:/Apps/Leave%20Tracker/server/.env.production)

```diff
-FRONTEND_URL="http://10.172.19.16"
-BACKEND_URL="http://10.172.19.15:5000"
-ALLOWED_ORIGINS="http://10.172.19.16,http://10.172.19.15:5000"
+FRONTEND_URL="http://10.172.19.15"
+BACKEND_URL="http://10.172.19.15:5000"
+ALLOWED_ORIGINS="http://10.172.19.15,http://10.172.19.15:5000"
```

---

### Deployment Script (Major Rewrite)

#### [MODIFY] [deploy-v2.ps1](file:///c:/Apps/Leave%20Tracker/deploy-v2.ps1)

This is the most impactful file. Key changes:
- **Remove `$FrontIp` parameter** — only one VM now (`$BackIp` → `$VmIp`)
- **Single SSH session** instead of two
- **Consolidated staging**: Frontend and backend go to the same VM, into `frontend/` and `backend/` subdirectories
- **Single version directory** contains both `frontend/` and `backend/` folders
- **Step 7 (Frontend)** and **Step 8 (Backend)** both target the same VM
- **Both watchdogs** are installed on the same machine
- **Nginx restart** happens on the same VM as backend cutover
- **Rollback** reverts one junction that contains both frontend + backend

Major structural changes:
1. Parameters: `$FrontIp` removed, `$BackIp` renamed to `$VmIp` (default `10.172.19.15`)
2. SSH connections: One session instead of two
3. Staging: `$localFrontStage` stages into `frontend/dist/`, `$localBackStage` stages into `backend/`
4. Remote extraction: Both zips extract into the same `$remoteVersionDir` under `frontend/` and `backend/` subdirectories
5. Nginx config: Deployed to the same VM
6. Health checks: All run on the same VM

---

### Ship Script

#### [MODIFY] [ship.ps1](file:///c:/Apps/Leave%20Tracker/ship.ps1)

- Update `$FrontIp` and `$BackIp` to single IP
- Cleanup targets: single VM instead of two

---

### Watchdog Scripts

#### [MODIFY] [ops/watchdog-nginx.ps1](file:///c:/Apps/Leave%20Tracker/ops/watchdog-nginx.ps1)

No functional changes needed — it already uses `localhost` for health checks and hardcoded nginx paths. It will run on the consolidated VM.

#### [MODIFY] [ops/watchdog-backend.ps1](file:///c:/Apps/Leave%20Tracker/ops/watchdog-backend.ps1)

No functional changes needed — same reason.

---

### Setup Scripts

#### [MODIFY] [setup-backend-vm.ps1](file:///c:/Apps/Leave%20Tracker/setup-backend-vm.ps1) → Rename to `setup-vm.ps1`

Consolidated single-VM setup script:
- Install Node.js
- Install Nginx
- Create folder structure (`frontend/`, `backend/`)
- Open ports 80 and 5000
- Create `.env` template with updated IPs

#### [DELETE] [setup-frontend-vm.ps1](file:///c:/Apps/Leave%20Tracker/setup-frontend-vm.ps1)

No longer needed — the consolidated `setup-vm.ps1` handles both.

---

### Install Watchdogs Script

#### [MODIFY] [install-watchdogs.ps1](file:///c:/Apps/Leave%20Tracker/install-watchdogs.ps1)

- Remove `$FrontIp` parameter — both watchdogs go to the same VM
- Single SSH session
- Install both nginx and backend watchdog scripts on `10.172.19.15`

---

### Probe Script

#### [MODIFY] [probe_vms_v2.ps1](file:///c:/Apps/Leave%20Tracker/probe_vms_v2.ps1)

- Remove `10.172.19.16` from VM list
- Combine all checks (nginx + backend) onto `10.172.19.15`

---

### Documentation Updates

#### [MODIFY] [README.md](file:///c:/Apps/Leave%20Tracker/README.md)

Update architecture table, environment variables, and IP references.

#### [MODIFY] [TECHNICAL_DOCS.md](file:///c:/Apps/Leave%20Tracker/TECHNICAL_DOCS.md)

Update VM topology from 3-VM to 2-VM.

#### [MODIFY] [WATCHDOG-SETUP.md](file:///c:/Apps/Leave%20Tracker/WATCHDOG-SETUP.md)

Update to reflect single-VM watchdog installation.

#### [MODIFY] [wiki/5-Deployment/Operations-Runbook.md](file:///c:/Apps/Leave%20Tracker/wiki/5-Deployment/Operations-Runbook.md)

Update system map, OpManager setup URLs, triage logic, and manual checks to reflect consolidated VM.

#### [MODIFY] [Technical_Guide.html](file:///c:/Apps/Leave%20Tracker/Technical_Guide.html)

Update the architecture diagrams, VM tables, deployment topology, and all IP references.

---

### Files That Need NO Changes (Good News)

| File | Reason |
|---|---|
| `src/lib/api.ts` | Already uses relative `/api` in production — works regardless of IP |
| `src/**` (all frontend code) | No hardcoded IPs |
| `server/**` (all backend code) | Reads URLs from `.env` at runtime |
| `ops/watchdog-nginx.ps1` | Uses `localhost` |
| `ops/watchdog-backend.ps1` | Uses `localhost` |

---

## Verification Plan

### Automated Tests

1. **Dry-run deployment**: `.\deploy-v2.ps1 -DryRun` — verify build and staging work with new folder structure
2. **Health checks post-deploy**:
   - `http://10.172.19.15/health` → 200
   - `http://10.172.19.15/api/health` → 200  
   - `http://10.172.19.15:5000/health` → 200
3. **Probe script**: `.\probe_vms_v2.ps1` — verify all checks pass on single VM

### Manual Verification

1. SSH into `10.172.19.15` and verify folder structure:
   ```
   C:\AlanDick-LeaveTracker\app\frontend\dist\index.html  ← exists
   C:\AlanDick-LeaveTracker\app\backend\dist\server.js    ← exists
   ```
2. Open `http://10.172.19.15` in browser → Leave Tracker loads
3. Login and test approval workflow → emails contain `http://10.172.19.15/requests/<id>` links
4. Verify OpManager monitors work with new URLs
5. Run watchdog recovery test: kill nginx, wait 60s, confirm auto-recovery
