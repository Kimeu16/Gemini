# Unified Delivery Pipeline: `ship.ps1`

I have created a master orchestrator script called `ship.ps1`. This tool consolidates all the manual steps we've performed today into a single, safe, and automated command.

## How it works

The `ship.ps1` script follows a "Safe Delivery" pattern:
1.  **Cleanup**: Deletes local zips and junk files to ensure a fresh build.
2.  **Git Sync (Safe Mode)**: 
    - Detects if you have uncommitted changes.
    - If so, it prompts for a commit message, then commits and **pushes to GitHub**.
    - This ensures that what you deploy is *always* what is on GitHub.
3.  **Deploy**: Automatically triggers `deploy-v2.ps1` to build and push the code to your 3 VMs.

## How to use it

You can use the new command either via PowerShell or NPM:

### Option A: NPM (Easiest)
```powershell
npm run ship
```

### Option B: PowerShell
```powershell
.\ship.ps1
```

### Advanced Usage
- **Dry Run (Safety Test)**: Run the whole sync flow but skip remote VM changes.
  ```powershell
  .\ship.ps1 -DryRun
  ```
- **Skip DB Migration**: Use this if you are 100% sure the database hasn't changed.
  ```powershell
  .\ship.ps1 -MigrateDb $false
  ```

## Summary of Files
- **[ship.ps1](file:///c:/Apps/Leave%20Tracker/ship.ps1)**: The core orchestrator.
- **[package.json](file:///c:/Apps/Leave%20Tracker/package.json)**: Updated to include the `npm run ship` shortcut.

> [!IMPORTANT]
> Because we recently added major sequential reservation features, `ship.ps1` defaults to `-MigrateDb $true`. Ensure you have your SSH credentials ready when running the script.
