# Backend VM Config & SSH Fix Plan

The backend VM (`10.172.19.15`) is currently failing to start because the `.env` file contains invalid characters or encoding (likely UTF-16 with trailing spaces from the previous PowerShell `echo` command). This causes the `zod` environment validation to fail, leaving the server offline and resulting in the 502 error on the frontend.

## User Review Required

> [!IMPORTANT]
> **Windows Server Encoding**: Since we moved from CentOS to Windows Server, we must ensure that environment files are written in a format compatible with Node.js (UTF-8 without BOM).

> [!WARNING]
> **Database Host**: We are confirming the database is at `10.172.19.33`. The current `.env` reflects this.

## Proposed Changes

### 1. Re-writing `.env` on Backend VM (`10.172.19.15`)
- Use a single `Set-Content` or `Out-File -Encoding ascii` command via SSH to ensure the `.env` file is clean.
- Ensure no trailing spaces or hidden characters are present in the `DATABASE_URL` or `JWT_SECRET`.

### 2. Service Restart
- Run `pm2 restart leave-tracker-backend --update-env` to force PM2 to reload the clean environment variables.

### 3. Log Verification
- Inspect `err.log` and `out.log` on the backend VM to confirm the "Prisma connected successfully" message and that port 5000 is listening.

## Open Questions

- **Nginx Config Check**: Do we need to update the Nginx configuration on `10.172.19.16` to reflect any other changes (e.g. if the backend VM IP changed during the move to Windows VMs)? (Currently assuming `.15` is correct).

## Verification Plan

### Automated Tests
- `Invoke-SSHCommand -Command "netstat -ano | findstr :5000"`: Verify the process is listening.
- `Invoke-WebRequest -Uri "http://10.172.19.15:5000/health"`: Verify health endpoint response.

### Manual Verification
- Test login with `tkymeu@gmail.com` / `0714229987` via the browser at `http://10.172.19.16/login`.
