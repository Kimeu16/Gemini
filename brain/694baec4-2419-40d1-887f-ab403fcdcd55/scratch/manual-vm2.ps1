# Manual Script for VM2
$VmUser = 'anthony.kimeu'
$cred = Get-Credential -UserName $VmUser -Message "Enter VM credentials for VM2 migration (10.172.19.15)"

Write-Host "Creating Session to VM2..."
$session = New-SSHSession -ComputerName 10.172.19.15 -Credential $cred -AcceptKey -Force

Write-Host "Creating Staging Directory..."
Invoke-SSHCommand -SessionId $session.SessionId -Command "powershell -Command `"md C:\AlanDick-LeaveTracker\staging -Force`""

Write-Host "Uploading Script..."
Set-SCPItem -ComputerName 10.172.19.15 -Credential $cred -Path "C:\Users\kymeu\.gemini\antigravity\brain\694baec4-2419-40d1-887f-ab403fcdcd55\scratch\migrate-vm2.ps1" -Destination "C:/AlanDick-LeaveTracker/staging/migrate.ps1" -Force -AcceptKey

Write-Host "Running Script..."
$result = Invoke-SSHCommand -SessionId $session.SessionId -Command "powershell.exe -ExecutionPolicy Bypass -File C:\AlanDick-LeaveTracker\staging\migrate.ps1"

foreach ($line in $result.Output) { Write-Host "  $line" }
foreach ($line in $result.Error) { Write-Host "  [ERR] $line" -ForegroundColor Red }

Remove-SSHSession -SessionId $session.SessionId
Write-Host "Done VM2"
