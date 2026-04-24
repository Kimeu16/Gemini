# Implementation Plan - PDF Layout Restoration

The goal is to eliminate section collisions in the Leave Request PDF by replacing hardcoded coordinates with a dynamic cursor logic.

## Proposed Changes

### PDF Template Logic

#### [MODIFY] [corporatePdf.ts](file:///c:/Apps/Leave%20Tracker/src/lib/corporatePdf.ts)
- Refactor the `generateLeaveRequestPdf` function to track a relative `currentY` coordinate.
- Replace hardcoded starting positions for Sections 2 and 3 with dynamic offsets based on the bottom of the previous section's content.
- **Modern Styling**: Remove `doc.rect` border calls for Section 1, 2, 3, and 4.
- **Subtle Content Grouping**: Replace borders with light `fieldBg` shading to maintain structural clarity without the heavy lines.
- **Section 2 (Leave Details)**: Start relative to Section 1 content + 12mm gutter.
- **Section 3 (Declaration of Reason)**: Start relative to Section 2 content + 12mm gutter.
- **Section 4 (Contact & Handover)**: Maintain existing dynamic spacing but ensure the minimum start point is calculated from the actually measured height of Section 3.

## Verification Plan

### Automated Verification
- I will perform a coordinate simulation check to ensure that every section header has at least **12mm** of vertical clearance from the box row above it.
- I will verify that the math accounts for potential multi-line wrapping in the "Leave Category" and "Leave Period" fields.

### Manual Verification
- I will ask the user to generate a new PDF and confirm that the "Declaration of Reason" header is properly distanced from the "Leave Details" boxes.
