# Implementation Plan: OpManager Monitoring Endpoint for Audit Logs

Create a specialized, public API endpoint that allows OpManager to retrieve a summary of recent user actions (User + Action + Time) for display and alerting.

## User Review Required

> [!IMPORTANT]
> The `/api/logs/monitor` endpoint will be **public** (unauthenticated). To maintain security, it will **only** return the User Name, Action Type, and Timestamp. It will **not** return sensitive details (IP addresses, specific form data, or system IDs).

## Proposed Changes

### Backend Service

#### [MODIFY] [audit.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/audit.controller.ts)
- Add `getAuditLogsForMonitoring` function.
- Query `prisma.logEntry` for the last 10 entries.
- Use `select` to return only safe fields: `{ action: true, createdAt: true, user: { select: { name: true } } }`.

#### [MODIFY] [audit.routes.ts](file:///c:/Apps/Leave%20Tracker/server/src/routes/audit.routes.ts)
- Add `router.get('/monitor', getAuditLogsForMonitoring)` **before** the `authenticate` middleware to allow OpManager access.

## Open Questions

- Is 10 entries sufficient for the OpManager dashboard? *Assessment: 10 is standard for most monitoring widgets.*

## Verification Plan

### Automated Tests
- Use PowerShell `Invoke-WebRequest` to hit `http://10.172.19.16/api/logs/monitor` and verify:
  1. It is reachable without an Authorization header.
  2. The response contains "action" and "user.name" fields.
  3. No sensitive data (details/IPs) is present.

### Manual Verification
- Ask the user to add this URL as a "REST API Monitor" in OpManager.
