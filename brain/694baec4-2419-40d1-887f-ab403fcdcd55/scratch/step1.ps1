$VmUser = 'anthony.kimeu'
$cred = Get-Credential -UserName $VmUser -Message "Enter VM credentials for VM2 (10.172.19.15)"
$session = New-SSHSession -ComputerName 10.172.19.15 -Credential $cred -AcceptKey -Force

Invoke-SSHCommand -SessionId $session.SessionId -Command "mkdir C:\AlanDick-LeaveTracker | Out-Null"
Invoke-SSHCommand -SessionId $session.SessionId -Command "mkdir C:\AlanDick-LeaveTracker\metadata | Out-Null"
Invoke-SSHCommand -SessionId $session.SessionId -Command "mkdir C:\AlanDick-LeaveTracker\logs | Out-Null"
Invoke-SSHCommand -SessionId $session.SessionId -Command "mkdir C:\AlanDick-LeaveTracker\ops | Out-Null"
Invoke-SSHCommand -SessionId $session.SessionId -Command "mkdir C:\AlanDick-LeaveTracker\versions | Out-Null"

Invoke-SSHCommand -SessionId $session.SessionId -Command "schtasks /End /TN 'LeaveTrackerBackend' 2>&1 | Out-Null"
Invoke-SSHCommand -SessionId $session.SessionId -Command "schtasks /End /TN 'LeaveTrackerBackendWatchdog' 2>&1 | Out-Null"
Invoke-SSHCommand -SessionId $session.SessionId -Command "powershell -Command `"`$p=Get-Process -Name node -ErrorAction SilentlyContinue; if(`$p){Stop-Process -InputObject `$p -Force}`""

Invoke-SSHCommand -SessionId $session.SessionId -Command "if (exist C:\releases) move C:\releases\* C:\AlanDick-LeaveTracker\versions\"
Invoke-SSHCommand -SessionId $session.SessionId -Command "if (exist C:\releases) rmdir /s /q C:\releases"

Invoke-SSHCommand -SessionId $session.SessionId -Command "if (exist C:\ops\leave-tracker-monitor) move C:\ops\leave-tracker-monitor\* C:\AlanDick-LeaveTracker\ops\"
Invoke-SSHCommand -SessionId $session.SessionId -Command "if (exist C:\ops) rmdir /s /q C:\ops"

Invoke-SSHCommand -SessionId $session.SessionId -Command "if (exist C:\leave-tracker) rmdir /q C:\leave-tracker"

Remove-SSHSession -SessionId $session.SessionId
Write-Host "Manual VM2 Step 1 Done"
