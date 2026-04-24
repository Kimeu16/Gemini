# AlanDick Leave Tracker - VM Storage Cleanup Script
# Run this on VM2 (10.172.19.15) to recover disk space.

Write-Host "Starting Storage Cleanup..." -ForegroundColor Cyan

# 1. Clean up old deployment releases (Keep only the latest 2)
$releasesPath = "C:\releases"
if (Test-Path $releasesPath) {
    Write-Host "Cleaning up old releases in $releasesPath..."
    $releases = Get-ChildItem -Path $releasesPath -Directory | Sort-Object CreationTime -Descending
    if ($releases.Count -gt 2) {
        $releases | Select-Object -Skip 2 | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Removed $($releases.Count - 2) old releases." -ForegroundColor Green
    } else {
        Write-Host "No old releases to remove." -ForegroundColor Gray
    }
}

# 2. Clear deployment staging/temp files
$deployTemp = "C:\deploy"
if (Test-Path $deployTemp) {
    Write-Host "Clearing deployment landing zone ($deployTemp)..."
    Remove-Item "$deployTemp\*" -Recurse -Force -ErrorAction SilentlyContinue
}

# 3. Clear System Temp files
Write-Host "Clearing Windows temp folders..."
$tempPaths = @("C:\Windows\Temp", "C:\Users\$env:USERNAME\AppData\Local\Temp")
foreach ($path in $tempPaths) {
    if (Test-Path $path) {
        Get-ChildItem -Path $path -Recurse -File -ErrorAction SilentlyContinue | 
            Where-Object { $_.LastAccessTime -lt (Get-Date).AddDays(-1) } | 
            Remove-Item -Force -ErrorAction SilentlyContinue
    }
}

# 4. Truncate heavy log files (optional - handle with care)
$deployLog = "C:\deploy.log"
if (Test-Path $deployLog) {
    $size = (Get-Item $deployLog).Length / 1MB
    if ($size -gt 50) { # If log is > 50MB
        Write-Host "Truncating heavy deploy.log ($([math]::Round($size, 2)) MB)..."
        Clear-Content -Path $deployLog
    }
}

Write-Host "Cleanup Complete." -ForegroundColor Cyan
Get-PSDrive C | Select-Object Root, @{Name="Free(GB)";Expression={[math]::round($_.Free/1GB,2)}}
