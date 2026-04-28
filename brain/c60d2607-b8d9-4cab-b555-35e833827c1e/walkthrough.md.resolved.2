# Walkthrough - Leave Balances in PDF

I have successfully integrated the requester's real-time leave balances into the corporate Leave Application PDF. This enhancement provides clear visibility into the employee's current leave status during the approval process.

## Changes Made

### Type Safety
- **[leave.ts](file:///c:/Apps/Leave%20Tracker/src/types/leave.ts)**: Added `leaveBalances` to the `LeaveRequest` interface.
- **[corporatePdf.ts](file:///c:/Apps/Leave%20Tracker/src/lib/corporatePdf.ts)**: Added `leaveBalances` and `employeeDepartment` to the `LeaveRequestPdfData` interface to ensure strict typing and fix previous lint errors.

### Data Flow
- **[Requests.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Requests.tsx)**:
    - Updated the `useMemo` transformation to parse the `leaveBalances` JSON string from the API response into a typed object.
    - Updated `handleDownloadPdf` to pass this parsed data to the PDF generation utility.

### PDF Rendering
- **[corporatePdf.ts](file:///c:/Apps/Leave%20Tracker/src/lib/corporatePdf.ts)**:
    - Inserted a new section **"2. LEAVE BALANCE SUMMARY"** right after the Employee Details.
    - This section displays **Annual Leave Balance** and **Sick Leave Balance** in a professional, shaded grid layout.
    - Renumbered subsequent sections (Leave Details, Declaration of Reason, etc.) to maintain a logical flow.
    - Fixed undefined variable `lveId` by replacing it with a robust `formatDocumentReference(req)` call.

## Verification Results

### Manual Verification
- Verified that the data mapping correctly handles both stringified and object-based leave balances.
- The PDF layout was checked to ensure the new section fits seamlessly without breaking page transitions.
- Fixed lint errors ensuring the build process remains stable.

> [!TIP]
> Users can now see their updated balances every time they download their leave application form, reducing the need to check the dashboard separately.
