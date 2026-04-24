# Deployment Plan: Premium Calendar UI Release

Deploy the high-fidelity UI modernizations to the production environment using the AlanDick Zero-Downtime Deployment System.

## User Review Required

> [!IMPORTANT]
> This deployment targets the production environment (10.172.19.16 and 10.172.19.15). 
> It utilizes a **Blue-Green strategy** to ensure zero downtime. 

> [!NOTE]
> No database migrations are required for this release as the changes are strictly frontend UI/UX enhancements.

## Proposed Changes

### [Infrastructure] Deployment Script

#### [EXECUTE] [deploy-v2.ps1](file:///c:/Apps/Leave%20Tracker/deploy-v2.ps1)
- **Action**: Run the full production deployment pipeline.
- **Flags**: 
    - `-SkipConfirm`: For automated execution.
    - (Default IPs and VmUser will be used).

## Verification Plan

### Automated Steps (Built into Script)
1. **Linting & Build**: Verifies that the new React code compiles correctly.
2. **SHA256 Integrity**: ensures files transferred to the server match the local build.
3. **Pre-flight Health Check**: The script will spin up the "Green" instance on port 5001 and verify response before switching traffic.
4. **Final Smoke Test**: Verifies the production port (80/5000) is responding correctly post-junction switch.

### Manual Verification
- Access `http://10.172.19.16/calendar` (if possible from the agent's browser) to verify the "Yearly Heatmap" is visible in production.
