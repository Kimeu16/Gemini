# Orchestrator for VM Migration
$VmUser = 'anthony.kimeu'
if ($env:DEPLOY_VM_PASS) {
    $securePass = ConvertTo-SecureString $env:DEPLOY_VM_PASS -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential ($VmUser, $securePass)
} else {
    $cred = Get-Credential -UserName $VmUser -Message "Enter VM credentials for migration (10.172.19.16 / 10.172.19.15)"
}

$vms = @(
    @{ Name = "VM1 (Frontend)"; Ip = "10.172.19.16"; ScriptPath = "C:\Users\kymeu\.gemini\antigravity\brain\694baec4-2419-40d1-887f-ab403fcdcd55\scratch\migrate-vm1.ps1" },
    @{ Name = "VM2 (Backend)";  Ip = "10.172.19.15"; ScriptPath = "C:\Users\kymeu\.gemini\antigravity\brain\694baec4-2419-40d1-887f-ab403fcdcd55\scratch\migrate-vm2.ps1" }
)

foreach ($vm in $vms) {
    Write-Host "`n--- Migrating $($vm.Name) ($($vm.Ip)) ---" -ForegroundColor Cyan
    
    try {
        $session = New-SSHSession -ComputerName $vm.Ip -Credential $cred -AcceptKey -Force
        $content = Get-Content -Path $vm.ScriptPath -Raw
        
        if ($vm.Name -match "VM2") {
            # Bypassing "command line too long" by using a file-based approach
            Write-Host "  Ensuring remote directory structure..." -ForegroundColor DarkGray
            
            # 1. Ensure root and staging exist (using cmd to be safe)
            $setupCmd = "powershell -Command `"if (!(Test-Path 'C:\AlanDick-LeaveTracker\staging')) { New-Item -ItemType Directory -Path 'C:\AlanDick-LeaveTracker\staging' -Force }`""
            Invoke-SSHCommand -SessionId $session.SessionId -Command $setupCmd | Out-Null
            
            # 2. Upload script
            Write-Host "  Uploading migration script to VM2..." -ForegroundColor DarkGray
            Set-SCPItem -ComputerName $vm.Ip -Credential $cred -Path $vm.ScriptPath -Destination "C:\AlanDick-LeaveTracker\staging\migrate.ps1" -Force -AcceptKey
            
            # 3. Run script
            Write-Host "  Executing migration script on VM2..." -ForegroundColor DarkGray
            $command = "powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:\AlanDick-LeaveTracker\staging\migrate.ps1"
            $result = Invoke-SSHCommand -SessionId $session.SessionId -Command $command -TimeOut 600
        } else {
            # Standard encoded command for smaller scripts
            $bytes   = [System.Text.Encoding]::Unicode.GetBytes($content)
            $encoded = [Convert]::ToBase64String($bytes)
            $command = "powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand $encoded"
            $result = Invoke-SSHCommand -SessionId $session.SessionId -Command $command -TimeOut 600
        }
        
        if ($result.Output) {
            foreach ($line in $result.Output) {
                Write-Host "  $line" -ForegroundColor Gray
            }
        }
        
        if ($result.Error) {
            foreach ($err in $result.Error) {
                Write-Host "  [ERROR] $err" -ForegroundColor Red
            }
        }
        
        Remove-SSHSession -SessionId $session.SessionId
        Write-Host "--- $($vm.Name) Migration Finished ---" -ForegroundColor Green
    } catch {
        Write-Host "  [CRITICAL] $($_.Exception.Message)" -ForegroundColor Red
    }
}
