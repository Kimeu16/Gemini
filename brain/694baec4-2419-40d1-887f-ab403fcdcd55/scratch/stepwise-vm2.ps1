$VmUser = 'anthony.kimeu'
$cred = Get-Credential -UserName $VmUser -Message "Enter VM credentials for VM2 migration (10.172.19.15)"

$session = New-SSHSession -ComputerName 10.172.19.15 -Credential $cred -AcceptKey -Force

# We break the migration into smaller commands that definitely won't hit length limits
$commands = @(
    "powershell -NoProfile -Command `"schtasks /End /TN 'LeaveTrackerBackend' 2>&1`"",
    "powershell -NoProfile -Command `"schtasks /End /TN 'LeaveTrackerBackendWatchdog' 2>&1`"",
    "powershell -NoProfile -Command `"schtasks /End /TN 'LeaveTrackerBackendWatchdogOnStart' 2>&1`"",
    
    "powershell -NoProfile -Command `"`$p = Get-CimInstance Win32_Process | ? { `$_.Name -eq 'node.exe' -and `$_.CommandLine -match 'leave-tracker' }; if (`$p) { Stop-Process -Id `$p.ProcessId -Force }`"",
    
    "powershell -NoProfile -Command `"New-Item -ItemType Directory -Path 'C:\AlanDick-LeaveTracker' -Force`"",
    "powershell -NoProfile -Command `"New-Item -ItemType Directory -Path 'C:\AlanDick-LeaveTracker\versions' -Force`"",
    "powershell -NoProfile -Command `"New-Item -ItemType Directory -Path 'C:\AlanDick-LeaveTracker\ops' -Force`"",
    "powershell -NoProfile -Command `"New-Item -ItemType Directory -Path 'C:\AlanDick-LeaveTracker\staging' -Force`"",
    "powershell -NoProfile -Command `"New-Item -ItemType Directory -Path 'C:\AlanDick-LeaveTracker\logs' -Force`"",
    "powershell -NoProfile -Command `"New-Item -ItemType Directory -Path 'C:\AlanDick-LeaveTracker\metadata' -Force`"",
    
    "powershell -NoProfile -Command `"if (Test-Path 'C:\releases') { Copy-Item 'C:\releases\*' 'C:\AlanDick-LeaveTracker\versions' -Recurse -Force; Remove-Item 'C:\releases' -Recurse -Force }`"",
    "powershell -NoProfile -Command `"if (Test-Path 'C:\ops\leave-tracker-monitor') { Copy-Item 'C:\ops\leave-tracker-monitor\*' 'C:\AlanDick-LeaveTracker\ops' -Recurse -Force; Remove-Item 'C:\ops' -Recurse -Force }`"",
    
    "powershell -NoProfile -Command `"if (Test-Path 'C:\leave-tracker') { `$tgt = (Get-Item 'C:\leave-tracker').Target; if (`$tgt) { `$tgt = `$tgt.Replace('C:\releases', 'C:\AlanDick-LeaveTracker\versions'); New-Item -ItemType Junction -Path 'C:\AlanDick-LeaveTracker\app' -Target `$tgt -Force }; cmd /c rmdir 'C:\leave-tracker' }`"",
    
    "powershell -NoProfile -Command `"`$a = New-ScheduledTaskAction -Execute 'node.exe' -Argument 'C:\AlanDick-LeaveTracker\app\dist\server.js' -WorkingDirectory 'C:\AlanDick-LeaveTracker\app'; `$t = New-ScheduledTaskTrigger -AtStartup; `$s = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable; schtasks /Delete /TN 'LeaveTrackerBackend' /F 2>&1; Register-ScheduledTask -TaskName 'LeaveTrackerBackend' -Action `$a -Trigger `$t -Settings `$s -User 'SYSTEM' -RunLevel Highest -Force`"",
    
    "powershell -NoProfile -Command `"schtasks /Delete /TN 'LeaveTrackerBackendWatchdog' /F 2>&1; schtasks /Delete /TN 'LeaveTrackerBackendWatchdogOnStart' /F 2>&1`"",
    "powershell -NoProfile -Command `"schtasks /Create /F /RU SYSTEM /RL HIGHEST /SC MINUTE /MO 1 /TN 'LeaveTrackerBackendWatchdog' /TR 'powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:\AlanDick-LeaveTracker\ops\watchdog-backend.ps1'`"",
    "powershell -NoProfile -Command `"schtasks /Create /F /RU SYSTEM /RL HIGHEST /SC ONSTART /TN 'LeaveTrackerBackendWatchdogOnStart' /TR 'powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:\AlanDick-LeaveTracker\ops\watchdog-backend.ps1'`"",
    
    "powershell -NoProfile -Command `"schtasks /Run /TN 'LeaveTrackerBackendWatchdog'`""
)

foreach ($cmd in $commands) {
    Write-Host "Executing..." -ForegroundColor DarkGray
    $res = Invoke-SSHCommand -SessionId $session.SessionId -Command $cmd
    if ($res.Error) { Write-Host "Error: $($res.Error)" -ForegroundColor Red }
}

Remove-SSHSession -SessionId $session.SessionId
Write-Host "Migration for VM2 Complete!" -ForegroundColor Green
