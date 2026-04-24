$VmUser = 'anthony.kimeu'
$cred = Get-Credential -UserName $VmUser -Message "Enter VM credentials for VM2 (10.172.19.15)"
$session = New-SSHSession -ComputerName 10.172.19.15 -Credential $cred -AcceptKey -Force

# We use Move-Item because Copy-Item timeouts on large node_modules
$commands = @(
    "powershell -NoProfile -Command `"if (Test-Path 'C:\releases') { Move-Item -Path 'C:\releases\*' -Destination 'C:\AlanDick-LeaveTracker\versions' -Force -ErrorAction SilentlyContinue; Remove-Item 'C:\releases' -Recurse -Force }`"",
    "powershell -NoProfile -Command `"if (Test-Path 'C:\ops\leave-tracker-monitor') { Move-Item -Path 'C:\ops\leave-tracker-monitor\*' -Destination 'C:\AlanDick-LeaveTracker\ops' -Force; Remove-Item 'C:\ops' -Recurse -Force }`"",
    "powershell -NoProfile -Command `"if (Test-Path 'C:\leave-tracker') { `$tgt = (Get-Item 'C:\leave-tracker').Target; if (`$tgt) { `$tgt = `$tgt.Replace('C:\releases', 'C:\AlanDick-LeaveTracker\versions'); New-Item -ItemType Junction -Path 'C:\AlanDick-LeaveTracker\app' -Target `$tgt -Force }; cmd /c rmdir 'C:\leave-tracker' }`"",
    "powershell -NoProfile -Command `"schtasks /Run /TN 'LeaveTrackerBackendWatchdog'`""
)

foreach ($cmd in $commands) {
    Write-Host "Executing..." -ForegroundColor DarkGray
    $res = Invoke-SSHCommand -SessionId $session.SessionId -Command $cmd
    if ($res.Error) { Write-Host "Error: $($res.Error)" -ForegroundColor Red }
}

Remove-SSHSession -SessionId $session.SessionId
Write-Host "Migration Fix for VM2 Complete!" -ForegroundColor Green
