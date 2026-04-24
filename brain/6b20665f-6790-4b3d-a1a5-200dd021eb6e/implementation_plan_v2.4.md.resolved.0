# Implementation Plan - Deployment Parity & Junction Stabilization (v2.4)

This plan addresses the issue where recent UI changes were not reflected in production because the frontend junction on VM1 (10.172.19.16) failed to update correctly, despite the deployment script reporting success.

## User Review Required

> [!IMPORTANT]
> **Zero-Downtime Swap Strategy**: We are switching from a "Delete-then-Create" junction strategy to a "Rename-then-Create-then-Cleanup" strategy. This is more robust on Windows specifically for Nginx/Node environments where file locks might prevent immediate deletion of an active junction point.

## Proposed Changes

### Deployment Pipeline
#### [MODIFY] [deploy-v2.ps1](file:///c:/Apps/Leave%20Tracker/deploy-v2.ps1)
- Update `JunctionCutover` logic for both Frontend and Backend.
- Implement a `Rename-Item` before `New-Item` to ensure the junction path is free.
- Add specific verification checks after the swap to confirm the junction target matches intent.

### Infrastructure (Immediate Fix)
#### [ACTION] Manual Junction Fix on VM1
- I will manually execute the junction swap on VM1 to bring it into parity with the latest code (`v20260409-0918`) while I prepare the script update.

## Verification Plan

### Automated Verification
- Run the updated `deploy-v2.ps1` script.
- The script will now include an explicit check: `Get-Item C:\leave-tracker | Select-Object -ExpandProperty Target` must match the new version directory.

### Manual Verification
- Use the browser subagent to visit `10.172.19.16/requests` and verify the label "Contact while on leave" is visible.
- Verify the PDF generator also displays the enlarged logo and updated labels.
