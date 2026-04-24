# Automated App Version Branding

This plan introduces a mechanism to automatically stamp every deployment with a version ID (Timestamp + Git Hash) and display it on the Login page footer.

## User Review Required

> [!TIP]
> I recommend placing the version string discreetly in the footer of the login page. It will look like: `v20260414-0902 (d2cf008)`.

## Proposed Changes

### [MODIFY] [deploy-v2.ps1](file:///c:/Apps/Leave%20Tracker/deploy-v2.ps1)
- Add a task in **Step 4 (Build Artifacts)** to generate `src/version.json` before running the Vite build.
- The JSON will contain:
  - `version`: The current `$versionTimestamp`.
  - `gitHash`: The current `$gitHash`.
  - `date`: The deployment date.

### [MODIFY] [Login.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Login.tsx)
- Import `version.json` (with a safety check for when it doesn't exist yet).
- Render the version string in the footer at the bottom of the login form.

## Open Questions

1. Should the version only be visible on the **Login** page, or would you like it in the **Dashboard sidebar/footer** as well?
2. Do you have a specific format you prefer? (e.g., "Build: v1.2.3" or "v2026-04-14-1200").

## Verification Plan

### Automated Tests
- Run `.\ship.ps1 -DryRun` to verify that `src/version.json` is generated correctly.
- Check the local dev server to see how the version looks in the UI.

### Manual Verification
- Deploy and confirm the version appears on the live login page.
