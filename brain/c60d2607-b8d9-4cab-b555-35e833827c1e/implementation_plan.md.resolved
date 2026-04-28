# Implementation Plan - Integrating Leave Balances into PDF

This plan details the changes required to display the requester's current leave balances in the generated corporate Leave Application PDF. This provides transparency for both the employee and the approvers.

## Proposed Changes

### 1. Types Update

#### [MODIFY] [leave.ts](file:///c:/Apps/Leave%20Tracker/src/types/leave.ts)
- Update `LeaveRequest` interface to include optional `leaveBalances`.

```typescript
export interface LeaveRequest {
  // ... existing fields ...
  leaveBalances?: {
    annual: number;
    sick: number;
  };
}
```

### 2. Frontend Data Fetching & Mapping

#### [MODIFY] [Requests.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Requests.tsx)
- Update the `useMemo` transformation for `requests` to extract `leaveBalances` from the nested `employee` object in the API response.
- Since `leaveBalances` is stored as a JSON string in the database, it will be parsed.
- Pass `leaveBalances` to `generateLeaveRequestPdf` in the `handleDownloadPdf` function.

### 3. PDF Generation Utility

#### [MODIFY] [corporatePdf.ts](file:///c:/Apps/Leave%20Tracker/src/lib/corporatePdf.ts)
- Update `LeaveRequestPdfData` interface to include `leaveBalances`.
- Update `generateLeaveRequestPdf` to render a new "LEAVE BALANCE SUMMARY" section, likely below the Employee Details or near the Leave Details section.
- Use the existing design system (shading, typography) to ensure the new section feels premium and integrated.

## Verification Plan

### Automated Tests
- None at this stage, but will verify via manual visual inspection of generated PDFs.

### Manual Verification
1. Open the Leave Requests page.
2. Click "View" on any request.
3. Click "Download PDF".
4. Verify that the generated PDF contains a section showing "Annual Leave Balance" and "Sick Leave Balance" with correct values.
5. Verify that the layout remains professional and doesn't break with the new section.
