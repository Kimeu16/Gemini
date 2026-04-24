$VmUser = 'anthony.kimeu'
if ($env:DEPLOY_VM_PASS) {
    $securePass = ConvertTo-SecureString $env:DEPLOY_VM_PASS -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential ($VmUser, $securePass)
} else {
    $cred = Get-Credential -UserName $VmUser -Message "Enter VM credentials for verification"
}

$session = New-SSHSession -ComputerName 10.172.19.16 -Credential $cred -AcceptKey -Force

# Create names for 5 days ago to today
$date1 = (Get-Date).AddDays(-4).ToString("yyyy-MM-dd")
$date2 = (Get-Date).AddDays(-3).ToString("yyyy-MM-dd")
$date3 = (Get-Date).AddDays(-2).ToString("yyyy-MM-dd")
$date4 = (Get-Date).AddDays(-1).ToString("yyyy-MM-dd")
$date5 = (Get-Date).ToString("yyyy-MM-dd")

Write-Host "--- LOG RETENTION PROOF (VM1) ---" -ForegroundColor Cyan

# 1. Setup
$setup = "New-Item -ItemType Directory -Path 'C:\AlanDick-LeaveTracker\logs\$date1' -Force; " +
         "New-Item -ItemType Directory -Path 'C:\AlanDick-LeaveTracker\logs\$date2' -Force; " +
         "New-Item -ItemType Directory -Path 'C:\AlanDick-LeaveTracker\logs\$date3' -Force; " +
         "New-Item -ItemType Directory -Path 'C:\AlanDick-LeaveTracker\logs\$date4' -Force; " +
         "New-Item -ItemType Directory -Path 'C:\AlanDick-LeaveTracker\logs\$date5' -Force"

Invoke-SSHCommand -SessionId $session.SessionId -Command "powershell -Command `"$setup`"" | Out-Null

# 2. Before
Write-Host "Folders BEFORE cleanup (Last 5 days created):" -ForegroundColor Gray
$before = Invoke-SSHCommand -SessionId $session.SessionId -Command "dir C:\AlanDick-LeaveTracker\logs"
foreach ($line in $before.Output) { if ($line -match "\d{4}-\d{2}-\d{2}") { Write-Host "  $line" } }

# 3. Cleanup
Write-Host "`nRunning Maintenance Script (cleanup-vm.ps1)..." -ForegroundColor Yellow
$cleanup = Invoke-SSHCommand -SessionId $session.SessionId -Command "powershell -File C:\AlanDick-LeaveTracker\ops\cleanup-vm.ps1"
foreach ($line in $cleanup.Output) { Write-Host "  $line" -ForegroundColor DarkGray }

# 4. After
Write-Host "`nFolders AFTER cleanup (Strict 3-day retention):" -ForegroundColor Green
$after = Invoke-SSHCommand -SessionId $session.SessionId -Command "dir C:\AlanDick-LeaveTracker\logs"
foreach ($line in $after.Output) { if ($line -match "\d{4}-\d{2}-\d{2}") { Write-Host "  $line" } }

Remove-SSHSession -SessionId $session.SessionId
