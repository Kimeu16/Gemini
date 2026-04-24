# Fix for Build Warnings and Cutover IOExceptions

The recent production deployment revealed two technical issues that should be addressed to ensure a 100% clean pipeline:
1. **TypeScript Build Errors**: The `verify-projects-flow.ts` script contains type mismatches that caused "Build completed with warnings".
2. **Junction IOExceptions**: Windows processes sometimes lock the `C:\leave-tracker` junction, causing `Rename-Item` or `Remove-Item` to fail during cutover.

## Proposed Changes

### 1. [Backend] Fix Validation Script
#### [MODIFY] [verify-projects-flow.ts](file:///c:/Apps/Leave%20Tracker/server/src/scripts/verify-projects-flow.ts)
- Correct the `leaveBalances` assignment by stringifying the JSON object.
- Remove non-existent fields (`employeeName`, `hodApprovalDate`, `hodApprovalComments`) and map them to the correct schema fields (`omApprovalDate`, `omApprovalComments`) as per the HOD flow implementation in the controller.

### 2. [Deployment] Hardened Junction Cutover
#### [MODIFY] [deploy-v2.ps1](file:///c:/Apps/Leave%20Tracker/deploy-v2.ps1)
- Update the cutover logic to use `cmd /c rmdir` for junction points instead of PowerShell's `Remove-Item`. 
- `rmdir` (the legacy command) is significantly more reliable at removing reparse points on Windows when there are open handles or directory locks, as it specifically targets the link rather than the content.

## Verification Plan

### Automated Tests
- Run `.\deploy-v2.ps1 -DryRun -SkipConfirm`.
- **Expected**: "Build Artifacts" should complete with **0 errors/warnings**. 
- **Expected**: All files should be correctly staged.

### Manual Verification
- Perform a live deployment.
- **Expected**: The "Atomic Cutover" step should complete without the `CLIXML` error block in the output.
