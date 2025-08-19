# Watcher.ps1
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\Users\*NAME*\*TARGET FOLDER*"
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

$action = {
    try {
        Start-Process -FilePath "cmd.exe" `
                      -ArgumentList "/c C:\Users\*NAME*\*TARGET FOLDER*\Retag_HEVC_to_HVC1_newdelete.bat" `
                      -WorkingDirectory "C:\Users\*NAME*\*TARGET FOLDER*" `
                      -WindowStyle Hidden
    } catch {
        # optional: silent logging in case of errors
        Add-Content -Path "$env:TEMP\WatcherErrors.log" -Value "$(Get-Date) ERROR: $_"
    }
}

Register-ObjectEvent $watcher Created -Action $action
Register-ObjectEvent $watcher Changed -Action $action
Register-ObjectEvent $watcher Renamed -Action $action

while ($true) { Start-Sleep 5 }
