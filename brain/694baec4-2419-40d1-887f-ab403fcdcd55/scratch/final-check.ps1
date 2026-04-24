$user = 'anthony.kimeu'
if ($env:DEPLOY_VM_PASS) {
    $pass = ConvertTo-SecureString $env:DEPLOY_VM_PASS -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential($user, $pass)
} else {
    $cred = Get-Credential -UserName $user -Message "Enter VM credentials"
}

$sess = New-SSHSession -ComputerName 10.172.19.16 -Credential $cred -AcceptKey -Force
$res = Invoke-SSHCommand -SessionId $sess.SessionId -Command 'dir C:\AlanDick-LeaveTracker\logs | select Name'
Write-Host "--- Current Logs on VM1 ---"
$res.Output | ForEach-Object { if ($_ -match "\d{4}-\d{2}-\d{2}") { Write-Host "  $_" } }
Remove-SSHSession -SessionId $sess.SessionId
