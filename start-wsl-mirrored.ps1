
# ==================================================
# Smart WSL Mirrored Startup Script
# GlobalProtect + Zscaler safe version (ASCII only)
# ==================================================

$MaxRetries = 6
$BaseDelay  = 5   # Seconds
$Attempt    = 1

function Wait-ServiceRunning {
    param (
        [string]$ServiceName,
        [int]$TimeoutSeconds = 30
    )

    $startTime = Get-Date
    while ((Get-Service $ServiceName).Status -ne 'Running') {
        if ((Get-Date) - $startTime -gt (New-TimeSpan -Seconds $TimeoutSeconds)) {
            throw "Timeout waiting for service: $ServiceName"
        }
        Start-Sleep -Seconds 1
    }
}

function Test-WSLMirroredNetworking {
    try {
        $routes = wsl.exe -e sh -c "ip route | grep -v lo"
        return ($routes -and -not ($routes -match "unreachable"))
    } catch {
        return $false
    }
}

Write-Host "Starting WSL with mirrored networking..."

while ($Attempt -le $MaxRetries) {

    Write-Host "Attempt $Attempt of $MaxRetries"

    Write-Host "Shutting down WSL..."
    wsl --shutdown | Out-Null

    Write-Host "Restarting Host Network Service (HNS)..."
    Restart-Service hns -Force

    Write-Host "Waiting for HNS to be fully operational..."
    Wait-ServiceRunning -ServiceName "hns"

    $Delay = $BaseDelay * $Attempt
    Write-Host "Waiting $Delay seconds for VPN filters to stabilize..."
    Start-Sleep -Seconds $Delay

    Write-Host "Starting WSL..."
    wsl | Out-Null

    Start-Sleep -Seconds 3

    if (Test-WSLMirroredNetworking) {
        Write-Host "SUCCESS: WSL started with MIRRORED networking"
        exit 0
    }

    Write-Host "Mirrored networking not available yet, retrying..."
    $Attempt++
}

Write-Host "ERROR: Failed to start WSL with mirrored networking after $MaxRetries attempts"
exit 1
