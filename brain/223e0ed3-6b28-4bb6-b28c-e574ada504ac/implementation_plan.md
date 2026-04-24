# Implementation Plan - Digital Signature Integration

This plan outlines the steps to integrate digital signatures into the AlanDick Leave Tracker, allowing for manual signature collection, scanning, and system-wide application for official document generation.

## Proposed Changes

### Backend (Server)

#### [MODIFY] [employee.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/employee.controller.ts)
- Add `updateEmployeeSignature` controller to allow Administrators to upload/update the signature blob for any user/employee.
- Ensure this action is logged in the `AuditLog`.

#### [MODIFY] [leave.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/leave.controller.ts)
- Update `adminApproveLeaveRequest` to snapshot the Administrator's current signature blob into the `LeaveRequest.approverSignature` field at the time of approval.
- (Optional) Ensure `omApprove` and `gmApprove` are consistently using the user's signature for PDF generation (already happening via relationship, but consider snapshotting if permanence is required).

#### [MODIFY] [employee.routes.ts](file:///c:/Apps/Leave%20Tracker/server/src/routes/employee.routes.ts)
- Expose `POST /employees/:id/signature` route, restricted to `ADMINISTRATOR` or `OPERATIONS_MANAGER` roles.

---

### Frontend (Client)

#### [MODIFY] [corporatePdf.ts](file:///c:/Apps/Leave%20Tracker/src/lib/corporatePdf.ts)
- Update `LeaveRequestPdfData` interface to include `approverSignature`.
- Refactor `drawSignatureTable` within `generateLeaveRequestPdf` to render base64 signature images for OM, GM, and Admin if available, falling back to italicized text.
- Ensure the 3rd row (CEO/Admin) uses the `approverSignature` from the request.

#### [MODIFY] [Employees.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Employees.tsx)
- Add a "Digital Signature" section to the Employee Details sheet.
- Implement an upload interface for Administrators to "input" the scanned signatures extracted from the manual authorization forms.
- Add a visual preview of the signature within the employee list or details.

#### [MODIFY] [Requests.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Requests.tsx)
- Update the `handleDownloadPDF` function to pass the `approverSignature` field to the PDF generator.

---

### Documentation & Assets

#### [NEW] [Manual Signature Extraction Guide](file:///c:/Apps/Leave%20Tracker/docs/Signature_Extraction_Guide.md)
- Provide a quick guide for the Admin on how to:
    1. Scan the signed `SignatureCollectionForm.html`.
    2. Use a tool (like Remove.bg or Photoshop) to extract a clean, transparent PNG signature.
    3. Upload it to the system.

## Verification Plan

### Automated Tests
- Verify `POST /employees/:id/signature` returns 200 and updates the database.
- Verify `adminApproveLeaveRequest` persists the signature blob.

### Manual Verification
1. Upload a signature for a test "General Manager" user.
2. Approve a leave request as that GM.
3. Generate the PDF and verify the signature appears in Row 2.
4. Repeat for the Administrator (Row 3).
5. Verify the "Remove Background" instructions result in a clean look on the PDF's light-gray signature boxes.
