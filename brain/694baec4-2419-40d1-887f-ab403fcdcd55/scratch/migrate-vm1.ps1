# VM1 Migration Script (Refactored)
$ErrorActionPreference = "Stop"

# 1. Stop components
Write-Output "Stopping watchdogs and nginx..."
schtasks /End /TN 'LeaveTrackerNginxWatchdog' 2>$null
schtasks /End /TN 'LeaveTrackerNginxWatchdogOnStart' 2>$null
Stop-Process -Name nginx -Force -ErrorAction SilentlyContinue

# 2. Create Unified Root
$root = 'C:\AlanDick-LeaveTracker'
Write-Output "Preparing structure at $root..."
New-Item -ItemType Directory -Path $root -Force | Out-Null
foreach ($sub in @('versions', 'ops', 'staging', 'logs', 'metadata')) {
    New-Item -ItemType Directory -Path (Join-Path $root $sub) -Force | Out-Null
}

# 3. Migrate Releases
if (Test-Path 'C:\releases') {
    Write-Output "Moving releases..."
    Copy-Item -Path 'C:\releases\*' -Destination (Join-Path $root 'versions') -Recurse -Force
    Remove-Item 'C:\releases' -Recurse -Force
}

# 4. Migrate Ops
$oldOps = 'C:\ops\leave-tracker-monitor'
if (Test-Path $oldOps) {
    Write-Output "Moving ops..."
    Copy-Item -Path "$oldOps\*" -Destination (Join-Path $root 'ops') -Recurse -Force
    Remove-Item 'C:\ops' -Recurse -Force
}

# 5. Handle Junction / App
if (Test-Path 'C:\leave-tracker') {
    Write-Output "Updating app junction..."
    $target = (Get-Item 'C:\leave-tracker').Target
    if ($target) {
        $newTarget = $target.Replace('C:\releases', 'C:\AlanDick-LeaveTracker\versions')
        New-Item -ItemType Junction -Path (Join-Path $root 'app') -Target $newTarget -Force | Out-Null
    }
    cmd /c rmdir 'C:\leave-tracker'
}

# 6. Update Nginx Config
$conf = 'C:\nginx\conf\nginx.conf'
if (Test-Path $conf) {
    Write-Output "Updating nginx.conf paths..."
    (Get-Content $conf) -replace 'C:/leave-tracker', 'C:/AlanDick-LeaveTracker/app' `
                         -replace 'C:\\leave-tracker', 'C:\\AlanDick-LeaveTracker\\app' | Set-Content $conf
}

# 7. Re-register Watchdog Task
Write-Output "Re-registering tasks..."
$wdScript = 'C:\AlanDick-LeaveTracker\ops\watchdog-nginx.ps1'
$taskCmd = "powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$wdScript`""
schtasks /Delete /TN 'LeaveTrackerNginxWatchdog' /F 2>$null
schtasks /Delete /TN 'LeaveTrackerNginxWatchdogOnStart' /F 2>$null
schtasks /Create /F /RU SYSTEM /RL HIGHEST /SC MINUTE /MO 1 /TN 'LeaveTrackerNginxWatchdog' /TR $taskCmd
schtasks /Create /F /RU SYSTEM /RL HIGHEST /SC ONSTART /TN 'LeaveTrackerNginxWatchdogOnStart' /TR $taskCmd

# 8. Start Watchdog
Write-Output "Starting watchdog..."
schtasks /Run /TN 'LeaveTrackerNginxWatchdog'
Write-Output "VM1 Migration Complete"
