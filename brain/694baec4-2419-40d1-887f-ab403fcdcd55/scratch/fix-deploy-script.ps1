$path = "c:\Apps\Leave Tracker\deploy-v2.ps1"
$content = Get-Content $path -Raw

# We fix the opening here-string (line 1008)
# We find the specific pattern and replace it
$oldStart = '    $cleanupScript = @"'
$newStart = '    $cleanupScript = @"' + "`r`n" # Ensure clean newline

# We fix the closing here-string (line 1032)
# We look for "@ with indentation and move it to start of line
$oldEnd = "`r`n    `"@`r`n"
$newEnd = "`r`n`"@`r`n"

$content = $content.Replace($oldStart, $newStart)
$content = $content.Replace($oldEnd, $newEnd)

# Final cleanup: ensure the string keeping versions 5 is changed to 3
$content = $content.Replace("Cleaning staging, versions (>5)", "Cleaning staging, versions (>3)")
$content = $content.Replace("Versions (keep 5)", "Versions (keep 3)")
$content = $content.Replace("if (`$items.Count -gt 5)", "if (`$items.Count -gt 3)")
$content = $content.Replace("Select-Object -Skip 5", "Select-Object -Skip 3")

Set-Content $path $content -NoNewline
Write-Host "Logic Sync and Syntax Fix Applied to deploy-v2.ps1"
