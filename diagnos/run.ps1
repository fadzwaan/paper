# Laptop Diagnostic Script - Comprehensive Version

$mdFile = "output_diagnostic.md"
$batteryReportFile = "battery_report.html"

# Pipeline-friendly Append-MD function
function Append-MD {
    param(
        [Parameter(ValueFromPipeline=$true)]
        $text
    )
    process {
        Add-Content -Path $mdFile -Value $text
    }
}

# Clear previous report if exists
if (Test-Path $mdFile) { Remove-Item $mdFile }

# Start Markdown
"# Laptop Diagnostic Report" | Append-MD
"`nGenerated on: $(Get-Date)`n" | Append-MD

# =========================
# 1. System Information
# =========================
"## System Information" | Append-MD
try {
    Get-ComputerInfo |
        Select-Object CsName, WindowsVersion, OsName, OsArchitecture, CsManufacturer, CsModel, CsProcessors, CsTotalPhysicalMemory |
        Format-List | Out-String -Width 200 | Append-MD
} catch { "Failed to retrieve system info: $_" | Append-MD }

# =========================
# 2. Battery Report
# =========================
"## Battery Report" | Append-MD
try {
    powercfg /batteryreport /output $batteryReportFile | Out-Null
    "Battery report generated: [$batteryReportFile]($batteryReportFile)" | Append-MD
} catch { "Failed to generate battery report: $_" | Append-MD }

# =========================
# 3. Running Processes
# =========================
"## Running Processes (Top 20 by CPU)" | Append-MD
try {
    Get-Process |
        Select-Object Name, Id, CPU, @{Name="RAM(MB)";Expression={[math]::Round($_.WS/1MB,2)}} |
        Sort-Object CPU -Descending |
        Select-Object -First 20 |
        Format-Table -AutoSize | Out-String -Width 200 | Append-MD
} catch { "Failed to get processes: $_" | Append-MD }

# =========================
# 4. Installed Applications
# =========================
"## Installed Applications" | Append-MD
try {
    Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* ,
                     HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
        Select-Object DisplayName, DisplayVersion, Publisher |
        Where-Object {$_.DisplayName} |
        Sort-Object DisplayName |
        Format-Table -AutoSize | Out-String -Width 200 | Append-MD
} catch { "Failed to get installed applications: $_" | Append-MD }

# =========================
# 5. Open Network Ports
# =========================
"## Open Network Ports" | Append-MD
try {
    Get-NetTCPConnection |
        Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State, OwningProcess |
        Format-Table -AutoSize | Out-String -Width 200 | Append-MD
} catch { "Failed to get open ports: $_" | Append-MD }

# =========================
# 6. RAM Usage
# =========================
"## RAM Usage" | Append-MD
try {
    Get-CimInstance Win32_OperatingSystem |
        Select-Object @{Name="TotalRAM(GB)";Expression={[math]::Round($_.TotalVisibleMemorySize/1MB,2)}},
                      @{Name="FreeRAM(GB)";Expression={[math]::Round($_.FreePhysicalMemory/1MB,2)}},
                      @{Name="UsedRAM(GB)";Expression={[math]::Round(($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)/1MB,2)}} |
        Format-Table -AutoSize | Out-String -Width 200 | Append-MD
} catch { "Failed to get RAM usage: $_" | Append-MD }

# =========================
# 7. Storage Usage
# =========================
"## Storage Usage" | Append-MD
try {
    Get-PSDrive -PSProvider FileSystem |
        Select-Object Name,
                      @{Name="Used(GB)";Expression={[math]::Round($_.Used/1GB,2)}},
                      @{Name="Free(GB)";Expression={[math]::Round($_.Free/1GB,2)}},
                      @{Name="Total(GB)";Expression={[math]::Round(($_.Used+$_.Free)/1GB,2)}} |
        Format-Table -AutoSize | Out-String -Width 200 | Append-MD
} catch { "Failed to get storage usage: $_" | Append-MD }

# =========================
# 8. Disk Health (SMART)
# =========================
"## Disk Health" | Append-MD
try {
    Get-PhysicalDisk |
        Select-Object FriendlyName, MediaType, HealthStatus, OperationalStatus,
                      @{Name="Size(GB)";Expression={[math]::Round($_.Size/1GB,2)}} |
        Format-Table -AutoSize | Out-String -Width 200 | Append-MD
} catch { "Failed to get disk health: $_" | Append-MD }

# =========================
# 9. GPU Information
# =========================
"## GPU Information" | Append-MD
try {
    Get-CimInstance Win32_VideoController |
        Select-Object Name, DriverVersion, CurrentHorizontalResolution, CurrentVerticalResolution,
                      @{Name="VRAM(GB)";Expression={[math]::Round($_.AdapterRAM/1GB,2)}} |
        Format-Table -AutoSize | Out-String -Width 200 | Append-MD
} catch { "Failed to get GPU info: $_" | Append-MD }

# =========================
# 10. CPU Usage
# =========================
"## CPU Information" | Append-MD
try {
    Get-CimInstance Win32_Processor |
        Select-Object Name, NumberOfCores, NumberOfLogicalProcessors,
                      @{Name="Usage(%)";Expression={$_.LoadPercentage}}, MaxClockSpeed |
        Format-Table -AutoSize | Out-String -Width 200 | Append-MD
} catch { "Failed to get CPU info: $_" | Append-MD }

# =========================
# 11. Startup Programs
# =========================
"## Startup Programs" | Append-MD
try {
    Get-CimInstance Win32_StartupCommand |
        Select-Object Name, Command, Location, User |
        Format-Table -AutoSize | Out-String -Width 200 | Append-MD
} catch { "Failed to get startup programs: $_" | Append-MD }

# =========================
# 12. Windows Defender Status
# =========================
"## Windows Defender / Antivirus Status" | Append-MD
try {
    Get-MpComputerStatus |
        Select-Object AMServiceEnabled, AntispywareEnabled, AntivirusEnabled,
                      RealTimeProtectionEnabled, AntivirusSignatureLastUpdated,
                      @{Name="LastScan";Expression={$_.QuickScanEndTime}} |
        Format-List | Out-String -Width 200 | Append-MD
} catch { "Failed to get Defender status: $_" | Append-MD }

# =========================
# 13. Pending Windows Updates
# =========================
"## Pending Windows Updates" | Append-MD
try {
    $updateSession = New-Object -ComObject Microsoft.Update.Session
    $updateSearcher = $updateSession.CreateUpdateSearcher()
    $pendingUpdates = $updateSearcher.Search("IsInstalled=0 and Type='Software'")
    if ($pendingUpdates.Updates.Count -eq 0) {
        "No pending updates found." | Append-MD
    } else {
        "Pending updates: $($pendingUpdates.Updates.Count)" | Append-MD
        $pendingUpdates.Updates | ForEach-Object { "- $($_.Title)" } | Append-MD
    }
} catch { "Failed to get pending updates: $_" | Append-MD }

# =========================
# 14. Last Windows Update
# =========================
"## Last Installed Windows Update" | Append-MD
try {
    Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 5 |
        Select-Object HotFixID, Description, InstalledOn |
        Format-Table -AutoSize | Out-String -Width 200 | Append-MD
} catch { "Failed to get update history: $_" | Append-MD }

# =========================
# 15. Recent Event Log Errors
# =========================
"## Recent System Errors (Last 7 Days)" | Append-MD
try {
    $since = (Get-Date).AddDays(-7)
    Get-WinEvent -FilterHashtable @{LogName='System'; Level=2; StartTime=$since} -MaxEvents 20 -ErrorAction SilentlyContinue |
        Select-Object TimeCreated, Id, ProviderName, Message |
        Format-Table -AutoSize -Wrap | Out-String -Width 300 | Append-MD
} catch { "No system errors found or failed to retrieve: $_" | Append-MD }

"## Recent Application Errors (Last 7 Days)" | Append-MD
try {
    $since = (Get-Date).AddDays(-7)
    Get-WinEvent -FilterHashtable @{LogName='Application'; Level=2; StartTime=$since} -MaxEvents 20 -ErrorAction SilentlyContinue |
        Select-Object TimeCreated, Id, ProviderName, Message |
        Format-Table -AutoSize -Wrap | Out-String -Width 300 | Append-MD
} catch { "No application errors found or failed to retrieve: $_" | Append-MD }

# =========================
# 16. System Uptime
# =========================
"## System Uptime" | Append-MD
try {
    $uptime = (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
    "Uptime: $($uptime.Days) days, $($uptime.Hours) hours, $($uptime.Minutes) minutes" | Append-MD
} catch { "Failed to get uptime: $_" | Append-MD }

# =========================
# 17. Network Info
# =========================
"## Network Adapters" | Append-MD
try {
    Get-NetAdapter |
        Select-Object Name, Status, MacAddress, LinkSpeed |
        Format-Table -AutoSize | Out-String -Width 200 | Append-MD
} catch { "Failed to get network adapters: $_" | Append-MD }

"## IP / DNS / Gateway Configuration" | Append-MD
try {
    Get-NetIPConfiguration |
        Select-Object InterfaceAlias, IPv4Address, IPv4DefaultGateway, DNSServer |
        Format-List | Out-String -Width 200 | Append-MD
} catch { "Failed to get IP config: $_" | Append-MD }

"## Wi-Fi Signal Strength" | Append-MD
try {
    $wifiInfo = netsh wlan show interfaces
    $wifiInfo | Out-String | Append-MD
} catch { "Failed to get Wi-Fi info: $_" | Append-MD }

# =========================
# 18. Active Power Plan
# =========================
"## Active Power Plan" | Append-MD
try {
    powercfg /list | Out-String | Append-MD
} catch { "Failed to get power plans: $_" | Append-MD }

# =========================
# 19. Firewall Status
# =========================
"## Firewall Status" | Append-MD
try {
    Get-NetFirewallProfile |
        Select-Object Name, Enabled |
        Format-Table -AutoSize | Out-String -Width 200 | Append-MD
} catch { "Failed to get firewall status: $_" | Append-MD }

# =========================
# 20. Local Users & Last Login
# =========================
"## Local User Accounts" | Append-MD
try {
    Get-LocalUser |
        Select-Object Name, Enabled, LastLogon, PasswordLastSet, PasswordExpires |
        Format-Table -AutoSize | Out-String -Width 200 | Append-MD
} catch { "Failed to get local users: $_" | Append-MD }

"`n---`nReport generation completed." | Append-MD
Write-Host "Diagnostic report saved to: $mdFile" -ForegroundColor Green