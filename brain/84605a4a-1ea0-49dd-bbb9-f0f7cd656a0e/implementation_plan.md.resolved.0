# Implementation Plan: Restyle OpManager Guide PDF

Restyle the OpManager Setup Guide for AlanDick & Company (EA) Ltd to be company-branded and "world class." The goal is to transform technical instructions into a high-fidelity, professional manual.

## User Review Required

> [!IMPORTANT]
> The final output will be a high-fidelity HTML document designed for "Print to PDF." This ensures maximum cross-platform quality and alignment with modern web aesthetics.

## Proposed Changes

### Documentation & Assets

#### [NEW] [OpManager-Guide.html](file:///c:/Apps/Leave%20Tracker/docs/OpManager-Guide.html)
- Create a premium HTML template using the AlanDick & Company branding.
- **Design System:**
  - **Typography:** Inter (Google Fonts) for body and headers.
  - **Palette:** Dark Navy (`#1a1a2e`), Gold/Champagne (`#d4af37`), and Sleek Grays.
  - **Layout:** Multi-section manual with Header/Footer parity for PDF printing.
  - **Interactive Elements:** (Styled for print) Clear code blocks, status badges, and triage flowcharts.
- **Content Structure:**
  1. **Cover Page:** High-impact branding with logo and document title.
  2. **Infrastructure Map:** Visual representation of VM roles.
  3. **Monitor Configuration:** Step-by-step OpManager setup (URL, Port, Process monitors).
  4. **Thresholds & Alerts:** Recommended settings for stability.
  5. **Triage & Recovery:** Logical flow for incident response.

### Component Logic

#### [MODIFY] [corporatePdf.ts](file:///c:/Apps/Leave%20Tracker/src/lib/corporatePdf.ts) (Optional/Reference)
- I will reference the existing `corporatePdf.ts` for logo usage and general "posh" style but will move to a more flexible HTML approach for this complex guide.

## Open Questions

- Does the user prefer a specific color palette variant (e.g., strictly Black/White as seen in some files, or the Navy/Gold seen in others)? *Assessment: I will proceed with Navy/Gold as it fits "World Class" better.*

## Verification Plan

### Automated Tests
- N/A (Documentation change)

### Manual Verification
1. Open the generated `OpManager-Guide.html` in the browser.
2. Verify visual fidelity: logo placement, font rendering, and sectioning.
3. Perform a "Print Preview" set to A4 to ensure layout stability for PDF generation.
