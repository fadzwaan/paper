
## some sama

```powershelll
clear recycle bin
docker system prune

```

# manage process

```powershell
Get-Process | Where-Object { $_.Name -like "*Telegram*" } | Stop-Process -Force

# 2. Show top processes using > 100MB RAM
Write-Output "`nProcesses using more than 100MB RAM:"
Get-Process | Where-Object { $_.WorkingSet64 -gt 100MB } | 
Sort-Object -Property WorkingSet64 -Descending | 
Select-Object Name, Id, @{Name="MemoryMB"; Expression = { "{0:N2}" -f ($_.WorkingSet64 / 1MB) }}

# 3. List all .exe files from running processes
Write-Output "`nList of .exe files from running processes:"
Get-Process | ForEach-Object {
    try {
        $_.Path
    } catch {
        # Some system processes may not expose path
        $null
    }
} | Where-Object { $_ -like "*.exe" } | Sort-Object -Unique

# 4. Monitor all active port usage
Write-Output "`nActive network connections and ports in use:"
Get-NetTCPConnection | 
Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State, OwningProcess | 
Sort-Object -Property LocalPort

# 5. Check ICMP (Ping) echo rule status
Write-Output "`nChecking if ping is allowed (ICMPv4-In):"
Get-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-In)" |
Select-Object DisplayName, Enabled, Profile, Direction, Action

# Also check ICMPv6 if needed
Write-Output "`nChecking if ping is allowed (ICMPv6-In):"
Get-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv6-In)" |
Select-Object DisplayName, Enabled, Profile, Direction, Action


```

## interactive manage process

```powershell
# Simple PowerShell Task Manager

function Show-Menu {
    Clear-Host
    Write-Host "=== PowerShell Task Manager ===" -ForegroundColor Cyan
    Write-Host "1. View all processes"
    Write-Host "2. Search for a process by name"
    Write-Host "3. Kill a process by ID"
    Write-Host "4. Kill a process by name"
    Write-Host "5. Exit"
}

function List-AllProcesses {
    Get-Process | Sort-Object CPU -Descending | Format-Table Id, ProcessName, CPU -AutoSize
    Pause
}

function Search-ProcessByName {
    $name = Read-Host "Enter process name to search"
    Get-Process | Where-Object { $_.ProcessName -like "*$name*" } | Format-Table Id, ProcessName, CPU -AutoSize
    Pause
}

function Kill-ProcessById {
    $id = Read-Host "Enter Process ID to kill"
    try {
        Stop-Process -Id $id -Force
        Write-Host "Process with ID $id killed." -ForegroundColor Green
    } catch {
        Write-Host "Failed to kill process with ID $id" -ForegroundColor Red
    }
    Pause
}

function Kill-ProcessByName {
    $name = Read-Host "Enter Process Name to kill"
    try {
        Stop-Process -Name $name -Force
        Write-Host "Process '$name' killed." -ForegroundColor Green
    } catch {
        Write-Host "Failed to kill process '$name'" -ForegroundColor Red
    }
    Pause
}

# Main Loop
do {
    Show-Menu
    $choice = Read-Host "Choose an option (1-5)"
    switch ($choice) {
        "1" { List-AllProcesses }
        "2" { Search-ProcessByName }
        "3" { Kill-ProcessById }
        "4" { Kill-ProcessByName }
        "5" { Write-Host "Exiting..."; break }
        default { Write-Host "Invalid choice. Try again." -ForegroundColor Yellow }
    }
} while ($true)

```

## combine ics files
```python
import os

def combine_ics_files(input_folder, output_file):
    combined_events = []
    for filename in os.listdir(input_folder):
        if filename.endswith(".ics"):
            path = os.path.join(input_folder, filename)
            with open(path, 'r') as file:
                lines = file.readlines()

            inside_event = False
            for line in lines:
                if line.strip() == "BEGIN:VEVENT":
                    inside_event = True
                    event = ["BEGIN:VEVENT"]
                elif line.strip() == "END:VEVENT":
                    event.append("END:VEVENT")
                    combined_events.extend(event)
                    inside_event = False
                elif inside_event:
                    event.append(line.strip())

    with open(output_file, 'w') as outfile:
        outfile.write("BEGIN:VCALENDAR\n")
        outfile.write("VERSION:2.0\n")
        outfile.write("CALSCALE:GREGORIAN\n")
        outfile.write("METHOD:PUBLISH\n")
        outfile.write("PRODID:-//Combined ICS//EN\n")
        for event in combined_events:
            outfile.write(f"{event}\n")
        outfile.write("END:VCALENDAR\n")

    print(f"Combined ICS saved to: {output_file}")

combine_ics_files("./ics_files", "combined_calendar.ics")
```

## change wallpaper

```powershell
$useDownload = $true 

$imageUrl2 = "https://deltiasgaming.com/wp-content/uploads/2024/11/Nemu.jpg"
$downloadPath = "$env:USERPROFILE\Downloads\wallpaper.jpg"
$localImagePath = "$env:USERPROFILE\yourpath.jpg"

function Download-Wallpaper {
    param (
        [string]$Url,
        [string]$OutputPath
    )

    Write-Host "Downloading image from $Url"
    try {
        Invoke-WebRequest -Uri $Url -OutFile $OutputPath -UseBasicParsing
        Write-Host "Download complete: $OutputPath"
        return $OutputPath
    } catch {
        Write-Host "Failed to download your wallpaper: $_"
        return $null
    }
}

function Set-Wallpaper {
    param (
        [string]$ImagePath
    )

    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendWinIniChange = 0x02

    # ✅ Only add the type if not already added
    if (-not ("Wallpaper" -as [type])) {
        Add-Type @"
        using System.Runtime.InteropServices;

        public class Wallpaper {
            [DllImport("user32.dll", SetLastError = true)]
            public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
        }
"@
    }

    if (Test-Path $ImagePath) {
        [Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $ImagePath, $UpdateIniFile -bor $SendWinIniChange) | Out-Null
        Write-Host "Wallpaper has been set to: $ImagePath"
    } else {
        Write-Host "Image not found: $ImagePath"
    }
}

# Main Logic
if ($useDownload) {
    $imagePath = Download-Wallpaper -Url $imageUrl -OutputPath $downloadPath
} else {
    $imagePath = $localImagePath
}

# Set the wallpaper if we have a valid image path
if ($imagePath) {
    Set-Wallpaper -ImagePath $imagePath
}

```

## check github repo

```powershell
$repoUrl = Read-Host "Enter GitHub repo URL"
$targetDir = "$env:TEMP\GitRepoFullClone"
if (Test-Path $targetDir) {
    Remove-Item -Recurse -Force $targetDir
}
git clone $repoUrl $targetDir
if (Test-Path $targetDir) {
    $sizeBytes = (Get-ChildItem -Recurse -Path $targetDir -Force | Where-Object { -not $_.PSIsContainer } | Measure-Object -Property Length -Sum).Sum
    $sizeMB = [math]::Round($sizeBytes / 1MB, 2)
    $sizeGB = [math]::Round($sizeBytes / 1GB, 2)
    $fileCount = (Get-ChildItem -Recurse -Path $targetDir -File -Force | Measure-Object).Count
    Write-Host "Total files: $fileCount"
    Write-Host "Total size: $sizeMB MB ($sizeGB GB, $sizeBytes bytes)"
    Remove-Item -Recurse -Force $targetDir
} else {
    Write-Host "Clone failed."
}

```

## speedtest

```
winget install Ookla.Speedtest.CLI
speedtest
```

## spotify

```powershell
https://accounts.spotify.com/authorize?client_id=9d84dbd28bb744e29368e0b0a9233b7e&response_type=token&redirect_uri=http://localhost:8888/callback&scope=user-top-read


$accessToken = "PASTE_THE_ACCESS_TOKEN_HERE"

$response = Invoke-RestMethod -Uri "https://api.spotify.com/v1/me/top/tracks?limit=20" `
  -Headers @{ Authorization = "Bearer $accessToken" }

$response.items | Select-Object name, @{Name="Artist";Expression={$_.artists[0].name}}, @{Name="Album";Expression={$_.album.name}} | Format-Table -AutoSize
```

## reset cursor

```powershell
# Cursor Machine ID Reset Script for Windows
# This script resets Cursor's machine identifiers without running the cursor-free-vip application
# It only modifies configuration files and does not run any external code

# Check for administrative privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "This script requires administrator privileges to update the Windows registry." -ForegroundColor Red
    Write-Host "Please right-click on PowerShell and select 'Run as Administrator', then run this script again." -ForegroundColor Yellow
    Write-Host "Press any key to exit..."
    $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    exit
}

# Helper function to generate IDs
function Generate-IDs {
    # Generate UUID for devDeviceId
    $devDeviceId = [guid]::NewGuid().ToString()
    
    # Generate machineId (64 char hex)
    $randomBytes = New-Object byte[] 32
    $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $rng.GetBytes($randomBytes)
    $machineId = -join ($randomBytes | ForEach-Object { $_.ToString("x2") })
    
    # Generate macMachineId (128 char hex)
    $randomBytesLarge = New-Object byte[] 64
    $rng.GetBytes($randomBytesLarge)
    $macMachineId = -join ($randomBytesLarge | ForEach-Object { $_.ToString("x2") })
    
    # Generate SQM ID (bracketed UUID)
    $sqmId = "{" + [guid]::NewGuid().ToString().ToUpper() + "}"
    
    return @{
        "devDeviceId" = $devDeviceId
        "machineId" = $machineId
        "macMachineId" = $macMachineId
        "sqmId" = $sqmId
    }
}

# Make sure Cursor is closed
$cursorProcess = Get-Process -Name "Cursor" -ErrorAction SilentlyContinue
if ($cursorProcess) {
    Write-Host "Cursor is currently running. Please close it before continuing." -ForegroundColor Yellow
    $response = Read-Host "Do you want to forcibly close Cursor now? (Y/N)"
    if ($response -eq "Y" -or $response -eq "y") {
        Stop-Process -Name "Cursor" -Force
        Start-Sleep -Seconds 2
    } else {
        Write-Host "Please close Cursor and run this script again." -ForegroundColor Red
        exit
    }
}

# Define file paths
$appDataPath = [Environment]::GetFolderPath("ApplicationData")
$cursorPath = Join-Path -Path $appDataPath -ChildPath "Cursor"
$machineIdPath = Join-Path -Path $cursorPath -ChildPath "machineId"
$userPath = Join-Path -Path $cursorPath -ChildPath "User"
$globalStoragePath = Join-Path -Path $userPath -ChildPath "globalStorage"
$storagePath = Join-Path -Path $globalStoragePath -ChildPath "storage.json"
$sqlitePath = Join-Path -Path $globalStoragePath -ChildPath "state.vscdb"

# Check if paths exist
if (-not (Test-Path -Path $cursorPath)) {
    Write-Host "Cursor installation not found at: $cursorPath" -ForegroundColor Red
    exit
}

Write-Host "=== Cursor Machine ID Reset Tool ===" -ForegroundColor Cyan
Write-Host "This script will reset your Cursor machine identifiers." -ForegroundColor Cyan
Write-Host "Found Cursor installation at: $cursorPath" -ForegroundColor Green

# Generate new IDs
Write-Host "`nGenerating new identifiers..." -ForegroundColor Cyan
$newIds = Generate-IDs

# Display the new IDs
Write-Host "`nGenerated new identifiers:" -ForegroundColor Green
Write-Host "devDeviceId: $($newIds.devDeviceId)" -ForegroundColor Gray
Write-Host "machineId: $($newIds.machineId)" -ForegroundColor Gray
Write-Host "macMachineId: $($newIds.macMachineId)" -ForegroundColor Gray
Write-Host "sqmId: $($newIds.sqmId)" -ForegroundColor Gray

# 1. Update MachineId file
Write-Host "`n[1/4] Updating machineId file..." -ForegroundColor Cyan
if (Test-Path -Path $machineIdPath) {
    Copy-Item -Path $machineIdPath -Destination "$machineIdPath.backup" -Force
    Write-Host "Created backup at: $machineIdPath.backup" -ForegroundColor Yellow
}
Set-Content -Path $machineIdPath -Value $newIds.devDeviceId -Force
Write-Host "Updated machineId file successfully" -ForegroundColor Green

# 2. Update storage.json
Write-Host "`n[2/4] Updating storage.json..." -ForegroundColor Cyan
if (Test-Path -Path $storagePath) {
    Copy-Item -Path $storagePath -Destination "$storagePath.backup" -Force
    Write-Host "Created backup at: $storagePath.backup" -ForegroundColor Yellow
    
    try {
        $storageContent = Get-Content -Path $storagePath -Raw | ConvertFrom-Json
        
        # Update or add the required values
        # Check and set each property, creating if not exists
        if (-not (Get-Member -InputObject $storageContent -Name "telemetry.devDeviceId")) {
            Add-Member -InputObject $storageContent -NotePropertyName "telemetry.devDeviceId" -NotePropertyValue $newIds.devDeviceId
        } else {
            $storageContent."telemetry.devDeviceId" = $newIds.devDeviceId
        }

        if (-not (Get-Member -InputObject $storageContent -Name "telemetry.machineId")) {
            Add-Member -InputObject $storageContent -NotePropertyName "telemetry.machineId" -NotePropertyValue $newIds.machineId
        } else {
            $storageContent."telemetry.machineId" = $newIds.machineId
        }

        if (-not (Get-Member -InputObject $storageContent -Name "telemetry.macMachineId")) {
            Add-Member -InputObject $storageContent -NotePropertyName "telemetry.macMachineId" -NotePropertyValue $newIds.macMachineId
        } else {
            $storageContent."telemetry.macMachineId" = $newIds.macMachineId
        }

        if (-not (Get-Member -InputObject $storageContent -Name "telemetry.sqmId")) {
            Add-Member -InputObject $storageContent -NotePropertyName "telemetry.sqmId" -NotePropertyValue $newIds.sqmId
        } else {
            $storageContent."telemetry.sqmId" = $newIds.sqmId
        }

        if (-not (Get-Member -InputObject $storageContent -Name "storage.serviceMachineId")) {
            Add-Member -InputObject $storageContent -NotePropertyName "storage.serviceMachineId" -NotePropertyValue $newIds.devDeviceId
        } else {
            $storageContent."storage.serviceMachineId" = $newIds.devDeviceId
        }
        
        $storageContent | ConvertTo-Json -Depth 10 | Set-Content -Path $storagePath
        Write-Host "Updated storage.json successfully" -ForegroundColor Green
    }
    catch {
        Write-Host "Error updating storage.json: $_" -ForegroundColor Red
        Write-Host "Skipping storage.json update" -ForegroundColor Yellow
    }
}
else {
    Write-Host "storage.json not found at: $storagePath" -ForegroundColor Yellow
    Write-Host "Creating new storage.json..." -ForegroundColor Yellow
    
    $storageContent = @{
        "telemetry.devDeviceId" = $newIds.devDeviceId
        "telemetry.machineId" = $newIds.machineId
        "telemetry.macMachineId" = $newIds.macMachineId
        "telemetry.sqmId" = $newIds.sqmId
        "storage.serviceMachineId" = $newIds.devDeviceId
    }
    
    New-Item -Path $globalStoragePath -ItemType Directory -Force | Out-Null
    $storageContent | ConvertTo-Json -Depth 10 | Set-Content -Path $storagePath
    Write-Host "Created new storage.json successfully" -ForegroundColor Green
}

# 3. Update SQLite database
Write-Host "`n[3/4] Updating SQLite database..." -ForegroundColor Cyan

if (Test-Path -Path $sqlitePath) {
    Copy-Item -Path $sqlitePath -Destination "$sqlitePath.backup" -Force
    Write-Host "Created backup at: $sqlitePath.backup" -ForegroundColor Yellow
    
    # Create a temporary Python script
    $pythonScript = @"
import sqlite3
import os

db_path = '$($sqlitePath.Replace('\', '\\'))'
print(f"Connecting to SQLite database at: {db_path}")

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Create the table if it doesn't exist
cursor.execute('''
    CREATE TABLE IF NOT EXISTS ItemTable (
        key TEXT PRIMARY KEY,
        value TEXT
    )
''')

# Values to update
keys_and_values = [
    ('telemetry.devDeviceId', '$($newIds.devDeviceId)'),
    ('telemetry.macMachineId', '$($newIds.macMachineId)'),
    ('telemetry.machineId', '$($newIds.machineId)'),
    ('telemetry.sqmId', '$($newIds.sqmId)'),
    ('storage.serviceMachineId', '$($newIds.devDeviceId)')
]

# Update each key
for key, value in keys_and_values:
    print(f"Updating {key} with new value")
    cursor.execute('INSERT OR REPLACE INTO ItemTable (key, value) VALUES (?, ?)', (key, value))

# Commit changes and close
conn.commit()
print("Changes committed to database")
conn.close()
print("Database updated successfully!")
"@
            
    $pythonScriptPath = "$env:TEMP\update_cursor_sqlite.py"
    Set-Content -Path $pythonScriptPath -Value $pythonScript
    
    # Try to run with Python
    try {
        Write-Host "Attempting to use Python to update SQLite database..." -ForegroundColor Yellow
        $pythonResult = & python $pythonScriptPath
        Write-Host $pythonResult -ForegroundColor Gray
        Write-Host "Updated SQLite database using Python successfully" -ForegroundColor Green
    }
    catch {
        Write-Host "Python execution failed. SQLite database could not be updated: $_" -ForegroundColor Red
        Write-Host "You may need to manually update the SQLite database or install Python." -ForegroundColor Yellow
    }
    
    # Clean up
    if (Test-Path -Path $pythonScriptPath) {
        Remove-Item -Path $pythonScriptPath -Force
    }
}
else {
    Write-Host "SQLite database not found at: $sqlitePath" -ForegroundColor Yellow
    Write-Host "This is normal if you haven't used Cursor before." -ForegroundColor Yellow
}

# 4. Update Windows Registry
Write-Host "`n[4/4] Updating Windows Registry MachineGuid..." -ForegroundColor Cyan
try {
    $registryPath = "HKLM:\SOFTWARE\Microsoft\Cryptography"
    $oldGuid = (Get-ItemProperty -Path $registryPath -Name "MachineGuid" -ErrorAction SilentlyContinue).MachineGuid
    
    if ($oldGuid) {
        Write-Host "Found existing MachineGuid: $oldGuid" -ForegroundColor Yellow
        # Create a backup in registry
        New-ItemProperty -Path $registryPath -Name "MachineGuid.backup" -Value $oldGuid -PropertyType String -Force | Out-Null
        Write-Host "Created backup in registry: MachineGuid.backup" -ForegroundColor Yellow
    }
    
    # Generate a new GUID for registry (different from the ones used in Cursor)
    $newMachineGuid = [guid]::NewGuid().ToString()
    Set-ItemProperty -Path $registryPath -Name "MachineGuid" -Value $newMachineGuid -Type String -Force
    Write-Host "Updated Windows Registry MachineGuid to: $newMachineGuid" -ForegroundColor Green
}
catch {
    Write-Host "Failed to update Windows Registry: $_" -ForegroundColor Red
    Write-Host "This step requires administrator privileges." -ForegroundColor Yellow
}

# Completion
Write-Host "`n=== Reset Complete ===" -ForegroundColor Green
Write-Host "Cursor machine identifiers have been reset successfully." -ForegroundColor Green
Write-Host "`nWhat's been done:" -ForegroundColor Cyan
Write-Host "1. Generated new unique identifiers" -ForegroundColor White
Write-Host "2. Updated machineId file at: $machineIdPath" -ForegroundColor White
Write-Host "3. Updated storage.json at: $storagePath" -ForegroundColor White
Write-Host "4. Attempted to update SQLite database at: $sqlitePath" -ForegroundColor White
Write-Host "5. Updated Windows Registry MachineGuid" -ForegroundColor White

Write-Host "`nBackups Created:" -ForegroundColor Cyan
if (Test-Path -Path "$machineIdPath.backup") { Write-Host "- $machineIdPath.backup" -ForegroundColor White }
if (Test-Path -Path "$storagePath.backup") { Write-Host "- $storagePath.backup" -ForegroundColor White }
if (Test-Path -Path "$sqlitePath.backup") { Write-Host "- $sqlitePath.backup" -ForegroundColor White }

Write-Host "`nNext Steps:" -ForegroundColor Cyan
Write-Host "1. Launch Cursor and complete any initial setup" -ForegroundColor White
Write-Host "2. If you need to revert these changes, rename the backup files to their original names" -ForegroundColor White

Write-Host "`nPress any key to exit..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
```

## clear recycle bin
`clear recycle bin`

## get latest files
```powershell
$latestFile = Get-ChildItem -Path "C:\Users\fadzw\Downloads\" | Sort-Object LastWriteTime -Descending | Select-Object -First 100
$latestFile
```

## jpg to pdf

```powershell
# Load .NET assembly
Add-Type -AssemblyName System.Drawing

# Set paths (automatically resolve ~ to user profile)
$jpgPath = "$HOME\Downloads\Fadzwan_IC_1.jpg"
$pdfPath = "$HOME\Downloads\Fadzwan_IC_1.pdf"

# Load the image
$image = [System.Drawing.Image]::FromFile($jpgPath)

# Set up the PrintDocument object
$printDoc = New-Object System.Drawing.Printing.PrintDocument
$printDoc.DocumentName = "Convert JPG to PDF"
$printDoc.PrinterSettings.PrinterName = "Microsoft Print to PDF"
$printDoc.PrinterSettings.PrintToFile = $true
$printDoc.PrinterSettings.PrintFileName = $pdfPath

# Draw the image on the PDF
$printDoc.add_PrintPage({
    param($sender, $e)
    $e.Graphics.DrawImage($image, 0, 0, $e.PageBounds.Width, $e.PageBounds.Height)
    $e.HasMorePages = $false
})

# Print to PDF
$printDoc.Print()

# Clean up
$image.Dispose()

Write-Host "✅ PDF created at: $pdfPath"

```

## download specific dir in github

```python
import os
import requests

GITHUB_API = "https://api.github.com/repos"

def download_github_folder(owner, repo, branch, folder_path, destination="."):
    url = f"{GITHUB_API}/{owner}/{repo}/contents/{folder_path}?ref={branch}"
    response = requests.get(url)
    
    if response.status_code != 200:
        print(f"Error fetching {url}: {response.status_code}")
        return

    items = response.json()
    if isinstance(items, dict) and items.get('type') == 'file':
        items = [items]

    for item in items:
        item_type = item["type"]
        item_path = item["path"]
        download_url = item.get("download_url")

        local_path = os.path.join(destination, item_path)
        if item_type == "dir":
            os.makedirs(local_path, exist_ok=True)
            download_github_folder(owner, repo, branch, item_path, destination)
        elif item_type == "file":
            os.makedirs(os.path.dirname(local_path), exist_ok=True)
            print(f"Downloading {item_path}")
            file_data = requests.get(download_url)
            with open(local_path, "wb") as f:
                f.write(file_data.content)

if __name__ == "__main__":
    # 👇 Specific example for:
    # https://github.com/Samsar4/Ethical-Hacking-Labs/tree/master/2-Scanning-Networks
    owner = "Samsar4"
    repo = "Ethical-Hacking-Labs"
    branch = "master"
    folder_path = "2-Scanning-Networks"

    download_github_folder(owner, repo, branch, folder_path, destination="downloaded")
```

## check github repo

```powershell
$repoUrl = Read-Host "Enter GitHub repo URL"
$targetDir = "$env:TEMP\GitRepoFullClone"
if (Test-Path $targetDir) {
    Remove-Item -Recurse -Force $targetDir
}
git clone $repoUrl $targetDir
if (Test-Path $targetDir) {
    $sizeBytes = (Get-ChildItem -Recurse -Path $targetDir -Force | Where-Object { -not $_.PSIsContainer } | Measure-Object -Property Length -Sum).Sum
    $sizeMB = [math]::Round($sizeBytes / 1MB, 2)
    $sizeGB = [math]::Round($sizeBytes / 1GB, 2)
    $fileCount = (Get-ChildItem -Recurse -Path $targetDir -File -Force | Measure-Object).Count
    Write-Host "Total files: $fileCount"
    Write-Host "Total size: $sizeMB MB ($sizeGB GB, $sizeBytes bytes)"
    Remove-Item -Recurse -Force $targetDir
} else {
    Write-Host "Clone failed."
}

```

## bosan core

```powershell
QWRkLVR5cGUgLUFzc2VtYmx5TmFtZSBTeXN0ZW0uRHJhd2luZwoKZm9yZWFjaCAoJGlkIGluIDIxMzAwLi4yMTMxOSkgewogICAgdHJ5IHsKICAgICAgICAkdXJsID0gImh0dHBzOi8vaXRhbGVlbWMuaWl1bS5lZHUubXkvcGx1Z2luZmlsZS5waHAvJGlkL3VzZXIvaWNvbi9yZW11aS9mMz9yZXY9NDg5OTAiCiAgICAgICAgJGNsaWVudCA9IE5ldy1PYmplY3QgU3lzdGVtLk5ldC5XZWJDbGllbnQKICAgICAgICAkY2xpZW50LkhlYWRlcnMuQWRkKCJVc2VyLUFnZW50IiwgIlBvd2VyU2hlbGwiKQogICAgICAgICRieXRlcyA9ICRjbGllbnQuRG93bmxvYWREYXRhKCR1cmwpCgogICAgICAgICR0ZW1wRmlsZSA9ICIkZW52OlRFTVBcdXNlcl8kaWQuanBnIgogICAgICAgIFtTeXN0ZW0uSU8uRmlsZV06OldyaXRlQWxsQnl0ZXMoJHRlbXBGaWxlLCAkYnl0ZXMpCgogICAgICAgIFN0YXJ0LVByb2Nlc3MgJHRlbXBGaWxlCgogICAgICAgIFN0YXJ0LVNsZWVwIC1TZWNvbmRzIDUKICAgIH0gY2F0Y2ggewogICAgICAgIFdyaXRlLVdhcm5pbmcgIkZhaWxlZCB0byBwcm9jZXNzIElEICR7aWR9OiAkKCRfLkV4Y2VwdGlvbi5NZXNzYWdlKSIKICAgIH0KfQ==
```


## active hyper-v

```bat
pushd "%~dp0"
dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hv-home.txt
for /f %%i in ('findstr /i . hv-home.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
del hv-home.txt
Dism /online /enable-feature /featurename:Microsoft-Hyper-V -All /LimitAccess /ALL
pause
```
# manage device
``` powershell
# list all usb connected
Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } |
Select-Object FriendlyName, Manufacturer, Status
```

# manage update
```powershell
Install-Module -Name PSWindowsUpdate
Import-Module -Name PSWindowsUpdate
Get-WindowsUpdate -AcceptAll -Install -AutoReboot
```

# package manaagement 
```powershell
Find-Package -Name PSWindowsUpdate
Get-Package
Uninstall-Package -Name PSWindowsUpdate
Get-PackageProvider
Install-PackageProvider -Name NuGet -Force
Register-PackageSource -Name PSGallery -ProviderName NuGet -Location https://www.powershellgallery.com/api/v2/ -Trusted -Force
Save-Package -Name PSWindowsUpdate -Path C:\Temp #download without install 
```

# notebooks to python conversion

```python
import nbformat
from nbconvert import PythonExporter
import gradio as gr
import openai
import os 

from pathlib import Path


def ask_chatgpt_to_comment(code):
    prompt = (
        "Please comment each part of the follwoint python code clearly and concisely"
        "to explain its purpose. add comments above block :\n\n"
        f"{code}"
    )

    try:
        response = openai.ChatCompletion.create(
            model="gpt-4",
            messages = [
                {"role": "user", "content": prompt}
            ],
            temperature=0.3,
        )
        return response.choices[0].message.content 
    except Exception as e: 
        return f"#Error while getting comments from ChatGPT {str(e)}"

def convert_file(input_file, conversion_type):
    try:
        input_path = input_file.name
        file_extension = Path(input_path).suffix
        
        # Validate input file extension
        if conversion_type == "ipynb to py" and file_extension != ".ipynb":
            return None, "Error: Input file must be .ipynb for this conversion"
        elif conversion_type == "py to ipynb" and file_extension != ".py":
            return None, "Error: Input file must be .py for this conversion"
        
        # Determine output path and extension
        if conversion_type == "ipynb to py":
            output_path = input_path.replace(".ipynb", "_converted.py")
            with open(input_path, 'r', encoding='utf-8') as file:
                notebook_content = nbformat.read(file, as_version=4)
            python_exporter = PythonExporter()
            python_code, _ = python_exporter.from_notebook_node(notebook_content)

            commented_code = ask_chatgpt_to_comment(python_code)
            with open(output_path, 'w', encoding='utf-8') as py_file:
                py_file.write(commented_code)
        else:
            output_path = input_path.replace(".py", "_converted.ipynb")
            with open(input_path, 'r', encoding='utf-8') as file:
                python_code = file.read()
            notebook_node = nbformat.v4.new_notebook()
            notebook_node.cells.append(nbformat.v4.new_code_cell(python_code))
            with open(output_path, 'w', encoding='utf-8') as ipynb_file:
                nbformat.write(notebook_node, ipynb_file)
        
        return output_path, f"Conversion successful! Ready to download."
    
    except Exception as e:
        return None, f"Error during conversion: {str(e)}"

with gr.Blocks(title="Notebook Converter") as demo:
    gr.Markdown("""
    # 📓 Jupyter Notebook ↔ Python Script Converter
    Convert between Jupyter Notebook (.ipynb) and Python script (.py) files
    """)
    
    with gr.Row():
        with gr.Column():
            input_file = gr.File(
                label="Upload File",
                file_types=[".ipynb", ".py"],
                type="filepath"
            )
            conversion_type = gr.Radio(
                choices=["ipynb to py", "py to ipynb"],
                label="Conversion Type",
                value="ipynb to py"
            )
            convert_btn = gr.Button("Convert", variant="primary")
            
        with gr.Column():
            download_output = gr.File(label="Download Converted File")
            output_result = gr.Textbox(label="Conversion Status", interactive=False)
    
    convert_btn.click(
        fn=convert_file,
        inputs=[input_file, conversion_type],
        outputs=[download_output, output_result]
    )

if __name__ == "__main__":
    demo.launch()
````
# make chatgpt chat each other
```python
from openai import OpenAI
import httpx
import time 

client = OpenAI(
    api_key = "",
    http_client = httpx.Client(timeout=httpx.Timeout(60.0))
)

bot1_system = "You are nurcynorman, you embrace anarchy, you reject friends love, you pursue money and power, only reply in one word"
bot2_system = "You are openai. you are thoughtful , always reply in one sentence`"

bot1_message = "i want to to know every pattern and every secret and not be like anyone"

turns = 10

bot1_history = [{"role": "system", "content": bot1_system}]
bot2_history = [{"role": "system", "content": bot2_system}]

for i in range(turns):
    print(f"\n bot 1 {bot1_message}")
    bot1_history.append({"role":"user","content":bot1_message})

    bot2_history.append({"role": "user" , "content" : bot1_message})

    response2 = client.chat.completions.create(
        model = "gpt-4",
        messages = bot2_history
    )
    bot2_message = response2.choices[0].message.content
    print(f"bot 2 {bot2_message}")

    bot1_history.append({"role": "assistant", "content": bot1_message})
    bot2_history.append({"role": "assistant", "content": bot2_message})

    bot1_history.append({"role": "user", "content": bot2_message})
    response1 = client.chat.completions.create(
        model="gpt-4",
        messages=bot1_history
    )
    bot1_message = response1.choices[0].message.content
    print(f"🟢 Bot 1: {bot1_message}")

    bot1_history.append({"role": "assistant", "content": bot1_message})
    bot2_history.append({"role": "assistant", "content": bot1_message})

    time.sleep(1)
```