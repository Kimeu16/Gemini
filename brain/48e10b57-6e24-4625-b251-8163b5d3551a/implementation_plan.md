# Configure Public IP Access (40.90.111.70:8086)

Reconfigure the Leave Tracker to be accessed via the public IP `40.90.111.70:8086` (port-forwarded) instead of the current private IP `10.172.19.16:80`.

## Current Architecture

| Component | Private IP | Role |
|-----------|-----------|------|
| Frontend (Nginx) | `10.172.19.16:80` | Serves SPA + proxies `/api/` → backend |
| Backend (Node.js) | `10.172.19.15:5000` | Express API server |
| Database (SQL Server) | `10.172.19.33:1433` | Data store |

The port forwarding `40.90.111.70:8086 → 10.172.19.16:80` means traffic arrives at Nginx on port 80, but users access it via `http://40.90.111.70:8086`.

## User Review Required

> [!IMPORTANT]
> **Port forwarding target**: I'm assuming `40.90.111.70:8086` is forwarded to `10.172.19.16:80`. Is that correct, or does it forward to a different internal port?

> [!IMPORTANT]
> **Dual access**: Should the system continue to work on the private IP `10.172.19.16` (LAN) in addition to the public IP? Or is this a complete replacement?

> [!WARNING]
> **Email links**: Currently all notification emails contain links like `http://10.172.19.16/requests/<id>`. These will be updated to `http://40.90.111.70:8086/requests/<id>`. Managers outside the LAN will be able to click these links, but managers inside the LAN will also need to use the public IP. If you want LAN users to keep using the private IP, we'd need a more complex setup.

## Proposed Changes

The changes are split into **critical config files** (must change) and **documentation/scripts** (nice to keep updated).

---

### Critical Config Files (Must Change)

#### [MODIFY] [.env](file:///c:/Apps/Leave%20Tracker/server/.env)
```diff
-FRONTEND_URL="http://10.172.19.16"
+FRONTEND_URL="http://40.90.111.70:8086"

-ALLOWED_ORIGINS="http://10.172.19.16,http://10.172.19.15:5000,http://localhost:5173"
+ALLOWED_ORIGINS="http://40.90.111.70:8086,http://10.172.19.16,http://10.172.19.15:5000,http://localhost:5173"
```

#### [MODIFY] [.env.production](file:///c:/Apps/Leave%20Tracker/server/.env.production)
```diff
-FRONTEND_URL="http://10.172.19.16"
-ALLOWED_ORIGINS="http://10.172.19.16,http://10.172.19.15:5000"
+FRONTEND_URL="http://40.90.111.70:8086"
+ALLOWED_ORIGINS="http://40.90.111.70:8086,http://10.172.19.16,http://10.172.19.15:5000"
```
> The old private IP is kept in ALLOWED_ORIGINS so LAN users can still access the system if needed.

#### [MODIFY] [nginx.conf](file:///c:/Apps/Leave%20Tracker/nginx.conf)
```diff
-        server_name 10.172.19.16 ADCERPWEB;
+        server_name 40.90.111.70 10.172.19.16 ADCERPWEB;
```

#### [MODIFY] [nginx-windows.conf](file:///c:/Apps/Leave%20Tracker/nginx-windows.conf)
```diff
-        server_name 10.172.19.16 ADCERPWEB;
+        server_name 40.90.111.70 10.172.19.16 ADCERPWEB;
```

#### [MODIFY] [health-monitor.ts](file:///c:/Apps/Leave%20Tracker/server/ops/health-monitor.ts)
```diff
-  frontendUrl: process.env.FRONTEND_URL || 'http://10.172.19.16',
+  frontendUrl: process.env.FRONTEND_URL || 'http://40.90.111.70:8086',
```

---

### Frontend — No Code Changes Needed ✅

The frontend `src/lib/api.ts` already dynamically resolves the API URL:
- **Production**: uses relative `/api` (Nginx proxies it)
- **Development**: uses `window.location.hostname`

This means it will automatically work regardless of whether users access via `10.172.19.16` or `40.90.111.70:8086`.

---

### Deploy/Setup Scripts (Update defaults)

#### [MODIFY] [deploy-v2.ps1](file:///c:/Apps/Leave%20Tracker/deploy-v2.ps1)
Update the default `$FrontIp` parameter.

#### [MODIFY] [setup-vm.ps1](file:///c:/Apps/Leave%20Tracker/setup-vm.ps1)
Update hardcoded FRONTEND_URL and ALLOWED_ORIGINS in the env template.

#### [MODIFY] [deploy-native.ps1](file:///c:/Apps/Leave%20Tracker/deploy-native.ps1)
Update default `$FrontIp`.

---

### Documentation (Update references)

These files have hardcoded `10.172.19.16` references but are documentation-only. I'll update the key ones:

- `README.md` — User-facing docs
- `TECHNICAL_DOCS.md` — Architecture docs
- `WATCHDOG-SETUP.md` — Monitoring setup
- `ops/health-monitor.ps1` — Health check script

> [!NOTE]
> HTML documentation files (`Technical_Guide.html`, `deployment-guide.html`, `OpManager-Guide.html`) and markdown implementation notes (`IMPLEMENTATION-SUMMARY.md`, `wiki/`) also reference the old IP but are lower priority. I can update them if you'd like.

## Verification Plan

### Automated Tests
1. Restart the backend server and verify CORS accepts requests from `http://40.90.111.70:8086`
2. Verify Nginx config syntax with `nginx -t`
3. Hit the health endpoint from the public IP

### Manual Verification
- Access `http://40.90.111.70:8086` from a browser outside the LAN
- Verify email notification links point to the public IP
- Confirm LAN access via `10.172.19.16` still works (if desired)
