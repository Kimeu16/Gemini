$path = "c:\Apps\Leave Tracker\deploy-v2.ps1"
$content = Get-Content $path -Raw

# We need to find the entire Step 10 block and replace it with a clean, verified version
# This ensures that any previous broken edits are completely wiped.

$oldBlockPattern = '(?s)# ==================================================================.*?#  STEP 10: CLEANUP.*?Invoke-RemotePowerShell -Session \$backendSession  -Title "VM2 Cleanup" -Script \$cleanupScript'
$newBlock = @"
    # ==================================================================
    #  STEP 10: CLEANUP (Item 10: Retention)
    # ==================================================================

    Write-Step "10/10" "Cleanup" "Cleaning staging, versions (>3), old junctions, and daily logs (>3 days)"

    `$cleanupScript = @"
# 1. Staging
Remove-Item '`$remoteStaging\*' -Recurse -Force -ErrorAction SilentlyContinue

# 2. Versions (keep 3)
``$items = Get-ChildItem -Path '`$remoteReleases' -Directory -ErrorAction SilentlyContinue | Sort-Object CreationTime -Descending
if (``$items.Count -gt 3) {
    ``$items | Select-Object -Skip 3 | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}

# 3. Old Junction Remnants (keep 1)
``$oldFolders = Get-ChildItem -Path '`$remoteRoot' -Directory -Filter 'app-old-*' -ErrorAction SilentlyContinue | Sort-Object CreationTime -Descending
if (``$oldFolders.Count -gt 1) {
    ``$oldFolders | Select-Object -Skip 1 | ForEach-Object {
        if ((Get-Item ``$_.FullName).Attributes -match 'ReparsePoint') { cmd /c rmdir /q ``$_.FullName 2>``$null }
        else { Remove-Item ``$_.FullName -Recurse -Force }
    }
}

# 4. Daily Logs (keep last 3 days)
``$logs = Get-ChildItem -Path '`$remoteLogsDir' -Directory -ErrorAction SilentlyContinue | Sort-Object Name -Descending
if (``$logs.Count -gt 3) {
    ``$logs | Select-Object -Skip 3 | Remove-Item -Recurse -Force
}
"@
    Invoke-RemotePowerShell -Session `$frontendSession -Title "VM1 Cleanup" -Script `$cleanupScript
    Invoke-RemotePowerShell -Session `$backendSession  -Title "VM2 Cleanup" -Script `$cleanupScript
"@

$content = [regex]::Replace($content, $oldBlockPattern, $newBlock)

# Ensure no stray "@ at the very end of the try block before the catch
$content = $content.Replace("`r`n`n`r`n`r`n\"@", "`r`n`r`n")

Set-Content $path $content -NoNewline
Write-Host "Deployment script Step 10 Hard-Reset and Repaired."
