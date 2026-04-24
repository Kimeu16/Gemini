# Documentation Update Plan

Update the project `README.md` and `TECHNICAL_DOCS.md` to align with the current architecture, feature set, and deployment workflows after the recent 91-file cleanup.

## Proposed Changes

### [MODIFY] [README.md](file:///c:/Apps/Leave%20Tracker/README.md)
- **Authentication**: Remove all references to Google OAuth. Update to reflect Email/Phone + Password authentication.
- **Database**: Change PostgreSQL references to SQL Server 2022.
- **Features**: 
    - Trim leave types to: Annual, Sick, Maternity, and Paternity.
    - Remove "Electronic Signature" management from the Profile section.
    - Add "Enhanced Calendar" features (avatars, hover tooltips, type-specific coloring).
- **Deployment**: Replace PM2 instructions with the use of `deploy-v2.ps1` and `probe_vms_v2.ps1`.
- **Cleanup**: Update the project structure and installation steps to be accurate.

### [MODIFY] [TECHNICAL_DOCS.md](file:///c:/Apps/Leave%20Tracker/TECHNICAL_DOCS.md)
- **Tech Stack**: Ensure versions and names match `README.md`.
- **Architecture**: Confirm the 3-VM isolation architecture details are prominent.
- **Authentication**: Remove Google OAuth logic descriptions.

## Verification Plan

### Manual Verification
- Review both markdown files for accuracy and consistency.
- Ensure all file links in the documentation point to existing files.
