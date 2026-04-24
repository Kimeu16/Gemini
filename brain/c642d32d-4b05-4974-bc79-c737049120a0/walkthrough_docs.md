# Documentation Update Summary

The project documentation has been comprehensively updated to reflect the current technical architecture and feature set of the Leave Tracker system.

## Key Document Updates

### 1. [README.md](file:///c:/Apps/Leave%20Tracker/README.md)
The main project README has been overhauled to ensure accuracy for new developers and system administrators:
- **Tech Stack Sync**: Formally updated the database from PostgreSQL to **Microsoft SQL Server 2022**.
- **Auth Strategy**: Removed all references to Google OAuth; the system now explicitly uses **Email/Password** authentication.
- **Feature Set**: 
    - Trimmed leave types to: Annual, Sick, Maternity, and Paternity.
    - Highlighted **Enhanced Calendar** features including employee avatars, hover tooltips, and type-specific color coding.
- **Deployment**: Integrated instructions for the new **PowerShell automation** (`deploy-v2.ps1` and `probe_vms_v2.ps1`).

### 2. [TECHNICAL_DOCS.md](file:///c:/Apps/Leave%20Tracker/TECHNICAL_DOCS.md)
The technical documentation was refined for better internal consistency:
- **Major Cleanup**: Removed a redundant 100+ line duplicated section of the document.
- **Architecture**: Synchronized the **3-VM isolation** details and deployment safety protocols.
- **Service Logic**: Updated descriptions for the notification and email services to match the current implementation.

## Quality Improvements
- **Linting**: Fixed `MD040` errors in `README.md` by ensuring all fenced code blocks have proper language identifiers (`env`, `bash`, `powershell`, `text`).
- **Parity**: Ensured that both documents share identical technical specifications for the tech stack and system roles.
