# Implementation Plan - Admin Signature and Preview E-Signatures

This plan outlines the changes required to integrate the new Administrator signature (`mercy_signature.png`) into the leave request preview and ensure all approvers' e-signatures are displayed in the preview instead of their names.

## User Review Required

> [!IMPORTANT]
> The Admin signature will be displayed in the **Requests Preview** (web UI) but will be **excluded** from the final downloaded PDF, as it is intended for the CEO's manual signature.
> I will generate a test PDF named `test-signed-leave-request.pdf` (or similar) to demonstrate the signature placement if required, but the primary target is the preview.

## Proposed Changes

### Frontend (Requests Page)

#### [MODIFY] [Requests.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Requests.tsx)
- Define a mapping for default signature images:
    - OM: `/joram_OMsignature.png`
    - GM: `/willis_GMsignature.png`
    - Admin: `/mercy_signature.png`
    - HOD Projects: `/joshua_HODProjectssignature.png`
- Update the **Authorization Signatures** section in the preview dialog:
    - Replace the name-based fallback with an image-based display using the mapping above.
    - Logic: If `row.sig` is present, use it. Else if `row.date` is present (approved), use the default signature for that role.
- Update `handleDownloadPDF`:
    - Ensure the Admin signature (`mercy_signature.png`) is correctly handled if needed for testing, but typically it should be omitted for the final "CEO manual signature" version. I will set it to `undefined` or a placeholder for the final download to allow manual signature.

### PDF Generation Library

#### [MODIFY] [corporatePdf.ts](file:///c:/Apps/Leave%20Tracker/src/lib/corporatePdf.ts)
- Ensure the PDF generation logic correctly handles missing signatures by leaving the slot empty for manual signing if the `signatureImage` is not provided.

## Verification Plan

### Automated Tests
- I will run a script to check if the `mercy_signature.png` file is accessible in the `public` directory.
- I will verify the logic by checking the rendered HTML structure in the preview (if possible via browser tool).

### Manual Verification
- The user can open a leave request in the dashboard to see the e-signatures in the preview.
- The user can download the PDF and verify that the CEO slot is empty for manual signature.
