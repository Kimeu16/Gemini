# Automated Commit Messages for ship.ps1

This plan outlines the updates to `ship.ps1` to automatically generate descriptive commit messages based on the files currently being shipped.

## User Review Required

> [!NOTE]
> The script will attempt to summarize the changes (e.g., "deploy: updated 5 files including App.tsx"). You will still have the option to override this with a manual `-CommitMessage` parameter if desired.

## Proposed Changes

### [MODIFY] [ship.ps1](file:///c:/Apps/Leave%20Tracker/ship.ps1)
- Add logic to capture the output of `git status --porcelain`.
- Parse the list of changed files.
- Construct a commit message like: `deploy: synchronization of [X] changes ([List of main files...])`.
- Update the default flow to use this generated message instead of prompting the user.

## Open Questions

1. Do you want it to list *every* file changed, or just the first few (to avoid extremely long messages)?
2. Should I continue to keep the `-CommitMessage` parameter as an override?

## Verification Plan

### Automated Tests
- Run `.\ship.ps1 -DryRun` with local changes to verify the generated message output in the console.

### Manual Verification
- Verify the git log after a real run to ensure the messages are readable.
