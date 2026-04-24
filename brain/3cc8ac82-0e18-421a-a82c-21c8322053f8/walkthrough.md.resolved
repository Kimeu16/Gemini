# Deployment Gating & Corporate PDF Updates

The deployment checks and PDF styling enhancements have been successfully completed.

## 1. Safety Guard for Deploys
- The `deploy-posh.ps1` PowerShell script now requires explicit manual confirmation to proceed.
- When you execute the script, it will halt and prompt:
    1. "Have you tested these changes locally before proceeding? (yes/no)"
    2. "Are you sure you want to deploy to PROD? This will override current services. (yes/no)"
- Only a strict `yes` to both prompts will allow the deployment to continue. This entirely prevents accidental deployments without proper local testing.

## 2. Dynamic Leave Request Format
- I have established a clean formatting pattern to generate IDs for every Leave Tracker document: `LVE-{YYYYMM}-{1st 5 chars of Document ID}`. 
- Example output: **`LVE-202604-A1B2C`**.

## 3. High-Fidelity Corporate Header & PDF Setup
- The PDF header layout has been visually structured according to the reference format.
- **Accurate Branding:** The header title text and bottom divider are now styled using deep navy blue (`[24, 21, 69]`) rather than solid black, offering a premium and professional document appearance.
- **Header Elements:**
  - Standardized the left side logo placement with the core Company Information located directly beneath the logo block.
  - Placed the text "LEAVE TRACKER" boldly on the upper-right corner.
  - Positioned the document index label (e.g. `No: LVE-202604-ABCDE | Date: 8 Apr 2026`) just below the top text.
- **Page Layout Fixes:** Validated that the comprehensive Page 2 official approval section now generates *without* repeating the top header row, freeing up real estate and resolving the duplicate header issue.
