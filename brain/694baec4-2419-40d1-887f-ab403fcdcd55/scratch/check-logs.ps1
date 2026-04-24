$user = 'anthony.kimeu'
if ($env:DEPLOY_VM_PASS) {
    $pass = ConvertTo-SecureString $env:DEPLOY_VM_PASS -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential($user, $pass)
} else {
    $cred = Get-Credential -UserName $user -Message "Enter VM credentials"
}

$vms = @('10.172.19.16', '10.172.19.15')

foreach ($vm in $vms) {
    Write-Host "`n--- Checking Logs on $vm ---" -ForegroundColor Cyan
    try {
        $sess = New-SSHSession -ComputerName $vm -Credential $cred -AcceptKey -Force
        
        Write-Host "Current log folders in C:\AlanDick-LeaveTracker\logs:" -ForegroundColor Gray
        Invoke-SSHCommand -SessionId $sess.SessionId -Command 'dir C:\AlanDick-LeaveTracker\logs' | Select-Object -ExpandProperty Output
        
        # Test retention policy on VM1 (Frontend) if it's VM1
        if ($vm -eq '10.172.19.16') {
            Write-Host "`n[TEST] Verifying Retention Logic on VM1..." -ForegroundColor Yellow
            
            # 1. Create fake old log folders
            Write-Host "Creating fake log folders for 2026-01-01 to 2026-01-05..." -ForegroundColor Gray
            $makeFake = @"
                mkdir C:\AlanDick-LeaveTracker\logs\2026-01-01 -Force | Out-Null
                mkdir C:\AlanDick-LeaveTracker\logs\2026-01-02 -Force | Out-Null
                mkdir C:\AlanDick-LeaveTracker\logs\2026-01-03 -Force | Out-Null
                mkdir C:\AlanDick-LeaveTracker\logs\2026-01-04 -Force | Out-Null
                mkdir C:\AlanDick-LeaveTracker\logs\2026-01-05 -Force | Out-Null
"@
            Invoke-SSHCommand -SessionId $sess.SessionId -Command "powershell -Command `"$makeFake`"" | Out-Null
            
            Write-Host "Folders BEFORE cleanup:" -ForegroundColor Gray
            Invoke-SSHCommand -SessionId $sess.SessionId -Command 'dir C:\AlanDick-LeaveTracker\logs | select Name' | Select-Object -ExpandProperty Output
            
            # 2. Run cleanup script
            Write-Host "Running cleanup-vm.ps1..." -ForegroundColor Gray
            Invoke-SSHCommand -SessionId $sess.SessionId -Command 'powershell -File C:\AlanDick-LeaveTracker\ops\cleanup-vm.ps1' | Select-Object -ExpandProperty Output
            
            Write-Host "Folders AFTER cleanup (Should keep only the 3 newest):" -ForegroundColor Green
            Invoke-SSHCommand -SessionId $sess.SessionId -Command 'dir C:\AlanDick-LeaveTracker\logs | select Name' | Select-Object -ExpandProperty Output
        }
        
        Remove-SSHSession -SessionId $sess.SessionId
    } catch {
        Write-Error "Failed to connect to ${vm}: $($_.Exception.Message)"
    }
}
