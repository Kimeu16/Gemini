# Walkthrough: Automated App Versioning

I have implemented an automated versioning system that stamps the application with a unique ID (Timestamp + Git Hash) every time you deploy.

## Changes Made

### 1. Deployment Pipeline
Modified [deploy-v2.ps1](file:///c:/Apps/Leave%20Tracker/deploy-v2.ps1) to inject a dynamic metadata step:
- **Simplified Versioning**: Shortened from a long timestamp to a clean `vYY.MM.DD` format (e.g., `v26.04.14`) for better branding.
- **Traceability**: Still captures the current Git short-hash for precise technical tracking.

### 2. UI Visibility Improvements
Updated both [Login.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Login.tsx) and [Sidebar.tsx](file:///c:/Apps/Leave%20Tracker/src/components/layout/Sidebar.tsx):
- **High Contrast**: Switched from faint gray to darker text (`text-gray-600` on light, `text-white/70` on dark) to ensure readability on all screens.
- **Enhanced Design**: Added semantic labels ("Version" / "Build Version") and improved container styling (borders, shadows, and spacing).

## Verification Results

### Build Test (Final)
The final build successfully staged:
> `[OK] Version info staged: v26.04.14 (2736203)`

### Local Dev Verification
The `src/version.json` placeholder was created to ensure your local dev environment remains functional and shows `vDev-Local`.

---
> [!IMPORTANT]
> The version only updates when you run the **Ship** or **Deploy** scripts. Local development will always show `vDev-Local`.
