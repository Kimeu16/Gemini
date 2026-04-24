# Fix Deployment Failures

This plan addresses the backend build errors and SSH connectivity issues encountered during the recent deployment attempt.

## Proposed Changes

### Backend Code Fixes

#### [MODIFY] [auth.ts](file:///c:/Apps/Leave%20Tracker/server/src/middleware/auth.ts)
- Add `name: string` to the `user` object in the `AuthRequest` interface.
- Update the `authenticate` middleware to populate the `name` field from the database.

#### [MODIFY] [leave.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/leave.controller.ts)
- Replace `.replaceAll(/\s+/g, '_')` with `.replace(/\s+/g, '_')` on line 234 to ensure compatibility with the current TypeScript target (`es2016`).

### Infrastructure Investigation

#### [INVESTIGATE] VM2 Connectivity (URGENT)
- **Finding:** VM2 (`10.172.19.15`) is currently unreachable (Ping/SSH timed out). VM1 and VM3 are healthy.
- **Action:** Manual intervention required to bring VM2 back online or check its network settings. I cannot proceed with actual deployment to VM2 until this is resolved.

## Open Questions

- **Approval to Fix Code:** Should I proceed with the backend TypeScript fixes while you investigate VM2? This will at least resolve the build errors.
- **VM2 Status:** Is VM2 physically down or is there a known firewall change?

## Verification Plan

### Automated Tests
- Run `npm run build` in the `server` directory to verify code fixes.
- Run `Test-NetConnection` to verify connectivity to VM2.

### Manual Verification
- Re-run `npm run ship` and monitor the output for successful connection to both VMs.
