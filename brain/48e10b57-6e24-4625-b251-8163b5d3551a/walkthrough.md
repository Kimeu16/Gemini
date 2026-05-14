# Walkthrough: Public IP Access Configuration

## Summary

Configured the Leave Tracker to be accessible via **both** the new public IP `40.90.111.70:8086` (port-forwarded) **and** the existing private IP `10.172.19.16:80` (LAN).

## What Changed

### Architecture

```
Internet → 40.90.111.70:8086 → (port forward) → 10.172.19.16:80 → Nginx → /api/ → 10.172.19.15:5000
LAN      → 10.172.19.16:80   → Nginx → /api/ → 10.172.19.15:5000
```

### Files Modified (16 total)

#### Critical Config (5 files)
| File | Change |
|------|--------|
| `server/.env` | `FRONTEND_URL` → public IP; added public IP to `ALLOWED_ORIGINS` |
| `server/.env.production` | Same as above (production copy) |
| `nginx.conf` | Added `40.90.111.70` to `server_name` |
| `nginx-windows.conf` | Added `40.90.111.70` to `server_name` |
| `server/ops/health-monitor.ts` | Default fallback URL → public IP |

#### Deploy/Setup Scripts (8 files)
| File | Change |
|------|--------|
| `deploy-v2.ps1` | Default `$FrontIp` → `40.90.111.70` |
| `deploy-native.ps1` | Default `$FrontIp` → `40.90.111.70` |
| `setup-vm.ps1` | Env template updated |
| `install-watchdogs.ps1` | Default `$FrontIp` → `40.90.111.70` |
| `probe_vms_v2.ps1` | Default `$FrontIp` → `40.90.111.70` |
| `ops/health-monitor.ps1` | Default `$FrontendUrl` → public IP |
| `scratch/remote-setup-frontend.ps1` | Default `$FrontIp` → `40.90.111.70` |
| `install-health-monitor.ps1` | Summary output updated |

#### Documentation (3 files)
| File | Change |
|------|--------|
| `README.md` | Infrastructure table and examples updated |
| `TECHNICAL_DOCS.md` | Deployment section updated |
| `WATCHDOG-SETUP.md` | Health check URLs updated |

### No Code Changes Needed ✅

The frontend `src/lib/api.ts` already uses dynamic URL resolution:
- **Production**: relative `/api` path (Nginx proxies)
- **Development**: `window.location.hostname` auto-detection

This means it works regardless of which IP the user accesses from.

## Verification Results

| Test | Result |
|------|--------|
| Backend health check (`/health`) | ✅ 200 OK |
| CORS for `http://40.90.111.70:8086` | ✅ Accepted |
| CORS for `http://10.172.19.16` | ✅ Accepted (dual access) |

## Next Steps for Production

To deploy these changes to the production VMs, run:

```powershell
.\deploy-v2.ps1
```

This will:
1. Build the frontend and backend
2. Push the updated `nginx-windows.conf` to VM1 (Nginx will accept both IPs)
3. Push the updated `.env.production` to VM2 (CORS + FRONTEND_URL configured)
4. Restart services on both VMs
