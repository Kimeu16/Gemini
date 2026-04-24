$user = 'anthony.kimeu'
if ($env:DEPLOY_VM_PASS) {
    $pass = ConvertTo-SecureString $env:DEPLOY_VM_PASS -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential($user, $pass)
} else {
    $cred = Get-Credential -UserName $user -Message "Enter VM credentials"
}

$sess = New-SSHSession -ComputerName 10.172.19.16 -Credential $cred -AcceptKey -Force

# We rewrite the logic to be extremely explicit and robust
$debugScript = @'
    $logPath = "C:\AlanDick-LeaveTracker\logs"
    Write-Host "--- Debugging Log Retention ---"
    
    if (!(Test-Path $logPath)) {
        Write-Host "Logs path not found!"
        return
    }

    # Explicitly cast to array to ensure .Count works
    $days = @(Get-ChildItem -Path $logPath -Directory | Sort-Object Name -Descending)
    Write-Host "Found $($days.Count) folders."

    if ($days.Count -gt 3) {
        $toDelete = $days | Select-Object -Skip 3
        Write-Host "Selected $($toDelete.Count) folders for deletion."
        
        foreach ($folder in $toDelete) {
            Write-Host "Pruning: $($folder.Name) at $($folder.FullName)"
            try {
                Remove-Item -Path $folder.FullName -Recurse -Force -ErrorAction Stop
                Write-Host "  -> SUCCESS"
            } catch {
                Write-Host "  -> FAILED: $($_.Exception.Message)"
            }
        }
    } else {
        Write-Host "Limit not reached (Current: $($days.Count), Limit: 3)"
    }
    
    Write-Host "`n--- Remaining Folders ---"
    Get-ChildItem -Path $logPath -Directory | Select-Object -ExpandProperty Name
'@

$result = Invoke-SSHCommand -SessionId $sess.SessionId -Command "powershell -Command `"$debugScript`""
foreach ($line in $result.Output) { Write-Host $line }

Remove-SSHSession -SessionId $sess.SessionId
