# Walkthrough: OpManager Documentation & Monitoring Integration

I have completed the branding of the OpManager Setup Guide and implemented a specialized monitoring endpoint for real-time visibility within the OpManager dashboard.

## Changes Made

### 1. Branded Setup Guide
- **File:** [OpManager-Guide.html](file:///c:/Apps/Leave%20Tracker/docs/OpManager-Guide.html)
- **Identity:** Applied the AlanDick & Co (EA) Ltd world-class branding (Deep Navy and Gold).
- **Structure:**
  - **Cover Page:** High-impact corporate branding.
  - **System Map:** Clear layout of the 3-VM infrastructure.
  - **Monitor Tables:** Detailed configuration for OpManager URL and service monitors.
  - **Triage Guide:** Logical flowchart for incident response.

### 2. OpManager Monitoring Endpoint
- **Endpoint:** `GET /api/logs/monitor`
- **Logic:** Created a public, unauthenticated endpoint that returns the last 10 audit logs.
- **Security:** Limited the response to `user`, `action`, and `time` to prevent data leakage.
- **Data Format:**
  ```json
  {
    "status": "success",
    "logs": [
      { "user": "Anthony Kimeu", "action": "ADD_COMMENT", "time": "2026-04-09T..." }
    ]
  }
  ```

## How to use in OpManager

### For Documentation
1. Open [OpManager-Guide.html](file:///c:/Apps/Leave%20Tracker/docs/OpManager-Guide.html) in any browser.
2. Press **CTRL + P** to Print.
3. Select **Save as PDF**. 
4. **Important:** Enable "Background Graphics" in the print settings to ensure the corporate colors and logo are preserved.

### For Log Monitoring
1. In OpManager, create a new **REST API Monitor**.
2. **URL:** `http://10.172.19.16/api/logs/monitor`
3. **HTTP Method:** `GET`
4. **Display:** Set it to parse the `logs` array to show user actions directly in your dashboard.

> [!IMPORTANT]
> To activate the new monitor URL, you must run the deployment script `.\deploy-posh.ps1` to push the backend changes to the production server.
