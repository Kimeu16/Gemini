$VmUser = 'anthony.kimeu'
if ($env:DEPLOY_VM_PASS) {
    $securePass = ConvertTo-SecureString $env:DEPLOY_VM_PASS -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential ($VmUser, $securePass)
} else {
    $cred = Get-Credential -UserName $VmUser -Message "Enter VM credentials for verification"
}

$session = New-SSHSession -ComputerName 10.172.19.16 -Credential $cred -AcceptKey -Force

# We use simple commands to prove the logic
$testScript = @'
    # 1. Clear existing for clean test
    Remove-Item C:\AlanDick-LeaveTracker\logs\* -Recurse -Force -ErrorAction SilentlyContinue
    
    # 2. Create 5 days of dummy logs
    "2024-01-01","2024-01-02","2024-01-03","2024-01-04","2024-01-05" | ForEach-Object {
        New-Item -ItemType Directory -Path "C:\AlanDick-LeaveTracker\logs\$_" -Force | Out-Null
    }
    
    Write-Output "--- Logs BEFORE Cleanup ---"
    Get-ChildItem C:\AlanDick-LeaveTracker\logs | Select-Object -ExpandProperty Name
    
    # 3. Run Cleanup
    Write-Output "`n--- Running Maintenance Script ---"
    & C:\AlanDick-LeaveTracker\ops\cleanup-vm.ps1
    
    Write-Output "`n--- Logs AFTER Cleanup (Expect: 01-03, 01-04, 01-05) ---"
    Get-ChildItem C:\AlanDick-LeaveTracker\logs | Select-Object -ExpandProperty Name
'@

$result = Invoke-SSHCommand -SessionId $session.SessionId -Command "powershell -Command `"$testScript`""
foreach ($line in $result.Output) { Write-Host $line }

Remove-SSHSession -SessionId $session.SessionId
