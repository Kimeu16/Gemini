# Implementation Plan: "Next-Level" Structural Premium UI

![Next-Level Bento Portfolio Mockup](file:///C:/Users/kymeu/.gemini/antigravity/brain/a4d907e0-a32c-4c51-af4d-edf7b90ae575/next_level_bento_portfolio_mockup_1776761872209.png)

The "Titan Aurora" aesthetic is being evolved into a **Structural Premium** design system, inspired by top-tier **Dribbble** and **Figma** community showcases. We are moving away from soft organic blobs toward high-precision geometry, math-based SVG animations, and a structured "Bento Grid" layout that defines "Engineering Excellence."

## Design Pillars (Dribbble/Figma Inspired)

- **The Bento Grid**: A sophisticated card-based layout where components of varying sizes fit perfectly together, creating a sense of organized complexity.
- **SVG Kinetic Motion**: Replacing blurry CSS blobs with rhythmic, layered SVG sine waves that feel technically superior and professional.
- **Data-Dense Typography**: Using small, monospace labels (stats, tags) alongside large 'Syne' display fonts for a "high-tech document" feel.
- **Glassmorphism 2.0**: Ultra-sharp 1px borders with internal glows and high-saturation blurs.

## User Review Required

> [!IMPORTANT]
> The biggest change is the shift from "Aurora Blobs" to a **Kinetic SVG Wave**. This creates a more technical, professional feeling that aligns with Google/Microsoft standards.
> We will also introduce a **Bento Grid** layout which is the gold standard for high-end product design in 2025.

## Proposed Changes

---

### [Component] [NEW] [KineticWave](file:///c:/Apps/spark-portfolio-main/src/components/portfolio/KineticWave.tsx)
A high-fidelity SVG background component. It uses multiple overlapping sine waves with different speeds and amplitudes to create a "breathing" mechanical wave.

### [Component] [MODIFY] [Index](file:///c:/Apps/spark-portfolio-main/src/pages/Index.tsx)
The landing page will be refactored into a **Bento Grid** composition. Instead of standard vertical sections, we will use a CSS Grid to pack "Projects", "Skills", and "Intro" into a single cohesive, high-impact surface.

### [Component] [MODIFY] [Projects](file:///c:/Apps/spark-portfolio-main/src/components/portfolio/Projects.tsx)
Refactor cards into "Bento Cards" — some projects will occupy 2 columns, others 1, creating an asymmetric but balanced aesthetic favored by modern Figma templates.
- **Typography**: Refined spacing and weight hierarchy.
- **Borders**: Sharp 1px borders with "Subtle Glow" rather than large blurry shadows.
- **Grids**: Standardize on a sophisticated 12-column mesh grid.

### [Component] [MODIFY] [Hero](file:///c:/Apps/spark-portfolio-main/src/components/portfolio/Hero.tsx)
Add a "Scanline" or "Mesh" overlay to the hero to give it a high-tech "Architect" feel.

---

## Open Questions

- **Color Palette**: Do you prefer the current Electric Cyan/Purple, or should we move to a more "Stealth" monochrome with a single accent color (e.g., Pure White or Gold)?
- **Wave Complexity**: Should the wave be global (full screen) or confined to specific sections to maintain maximum focus on text?

## Verification Plan

### Automated Tests
- `npm run dev`: Verify fluid motion of the SVG waves.
- `npm run build`: Ensure no performance regressions with the new SVG components.

### Manual Verification
- Visual audit of the Bento Grid layout on mobile vs desktop.
- Testing the "Intelligent Cursor" interactions with the new bento cards.
