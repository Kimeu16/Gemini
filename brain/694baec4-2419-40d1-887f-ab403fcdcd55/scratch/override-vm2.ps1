$VmUser = 'anthony.kimeu'
$cred = Get-Credential -UserName $VmUser -Message "Enter VM credentials for VM2 migration (10.172.19.15)"

$session = New-SSHSession -ComputerName 10.172.19.15 -Credential $cred -AcceptKey -Force

# 1. Provide the migration script as a raw string directly to avoid file transfer
$migScript = @"
    # VM2 Migration Script (Refactored)
    `$ErrorActionPreference = "Stop"

    # 1. Stop components
    Write-Output "Stopping watchdogs and backend..."
    schtasks /End /TN 'LeaveTrackerBackend' 2>`$null
    schtasks /End /TN 'LeaveTrackerBackendWatchdog' 2>`$null
    schtasks /End /TN 'LeaveTrackerBackendWatchdogOnStart' 2>`$null

    # Kill backend processes
    `$AppPath = 'C:\leave-tracker'
    Get-CimInstance Win32_Process -ErrorAction SilentlyContinue |
        Where-Object { `$_.Name -eq 'node.exe' -and `$_.CommandLine -match [regex]::Escape(`$AppPath) } |
        ForEach-Object { Stop-Process -Id `$_.ProcessId -Force -ErrorAction SilentlyContinue }

    # 2. Create Unified Root
    `$root = 'C:\AlanDick-LeaveTracker'
    Write-Output "Preparing structure at `$root..."
    New-Item -ItemType Directory -Path `$root -Force | Out-Null
    foreach (`$sub in @('versions', 'ops', 'staging', 'logs', 'metadata')) {
        New-Item -ItemType Directory -Path (Join-Path `$root `$sub) -Force | Out-Null
    }

    # 3. Migrate Releases
    if (Test-Path 'C:\releases') {
        Write-Output "Moving releases..."
        Copy-Item -Path 'C:\releases\*' -Destination (Join-Path `$root 'versions') -Recurse -Force
        Remove-Item 'C:\releases' -Recurse -Force
    }

    # 4. Migrate Ops
    `$oldOps = 'C:\ops\leave-tracker-monitor'
    if (Test-Path `$oldOps) {
        Write-Output "Moving ops..."
        Copy-Item -Path "`$oldOps\*" -Destination (Join-Path `$root 'ops') -Recurse -Force
        Remove-Item 'C:\ops' -Recurse -Force
    }

    # 5. Handle Junction / App
    if (Test-Path 'C:\leave-tracker') {
        Write-Output "Updating app junction..."
        `$target = (Get-Item 'C:\leave-tracker').Target
        if (`$target) {
            `$newTarget = `$target.Replace('C:\releases', 'C:\AlanDick-LeaveTracker\versions')
            New-Item -ItemType Junction -Path (Join-Path `$root 'app') -Target `$newTarget -Force | Out-Null
        }
        cmd /c rmdir 'C:\leave-tracker'
    }

    # 6. Re-register Tasks
    Write-Output "Re-registering tasks..."
    `$appExec = 'C:\AlanDick-LeaveTracker\app\dist\server.js'
    `$appWork = 'C:\AlanDick-LeaveTracker\app'
    `$action = New-ScheduledTaskAction -Execute 'node.exe' -Argument `$appExec -WorkingDirectory `$appWork
    `$trigger = New-ScheduledTaskTrigger -AtStartup
    `$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
    schtasks /Delete /TN 'LeaveTrackerBackend' /F 2>`$null
    Register-ScheduledTask -TaskName 'LeaveTrackerBackend' -Action `$action -Trigger `$trigger -Settings `$settings -User 'SYSTEM' -RunLevel Highest -Force

    `$wdScript = 'C:\AlanDick-LeaveTracker\ops\watchdog-backend.ps1'
    `$taskCmd = "powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"`$wdScript`""
    schtasks /Delete /TN 'LeaveTrackerBackendWatchdog' /F 2>`$null
    schtasks /Delete /TN 'LeaveTrackerBackendWatchdogOnStart' /F 2>`$null
    schtasks /Create /F /RU SYSTEM /RL HIGHEST /SC MINUTE /MO 1 /TN 'LeaveTrackerBackendWatchdog' /TR `$taskCmd
    schtasks /Create /F /RU SYSTEM /RL HIGHEST /SC ONSTART /TN 'LeaveTrackerBackendWatchdogOnStart' /TR `$taskCmd

    # 7. Start Tasks
    Write-Output "Starting tasks..."
    schtasks /Run /TN 'LeaveTrackerBackendWatchdog'
    Write-Output "VM2 Migration Complete"
"@

# 2. Encode and execute
$bytes = [System.Text.Encoding]::Unicode.GetBytes($migScript)
$encoded = [Convert]::ToBase64String($bytes)
$cmd = "powershell -EncodedCommand $encoded"

Write-Host "Running Encoded Migration on VM2..."
$result = Invoke-SSHCommand -SessionId $session.SessionId -Command $cmd -TimeOut 600

foreach ($line in $result.Output) { Write-Host "  $line" -ForegroundColor Green }
foreach ($line in $result.Error) { Write-Host "  [ERR] $line" -ForegroundColor Red }

Remove-SSHSession -SessionId $session.SessionId
