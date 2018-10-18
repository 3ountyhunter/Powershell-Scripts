# This script was written by Michael Heeney and ***** ***** for Scripting for Network Administrators for Baker College of Jackson.
# First build date: 9/14/18
#--------------------------------------------------------------------------------------------------------------------------------

#Sets background and font color of text
$backgroundColor = "DarkMagenta"
$AltbackgroundColor = "Black"
$host.UI.RawUI.ForegroundColor = "White"
$host.UI.RawUI.BackgroundColor = "$backgroundColor"
function Show-Menu
{
     param (
           [string]$Title = 'Choose an option:'
     )
     Clear-Host
     Write-Host "================ $Title ================"
     # get-date
     ""
     Write-Host "1:  Press '1' for Hostname." -BackgroundColor $backgroundColor
     Write-Host "2:  Press '2' to show IP Address." -BackgroundColor $AltbackgroundColor
     Write-Host "3:  Press '3' to show DNS Servers." -BackgroundColor $backgroundColor
     Write-Host "4:  Press '4' to show Default Gateway." -BackgroundColor $AltbackgroundColor
     Write-Host "5:  Press '5' to show Available Memory." -BackgroundColor $backgroundColor
     Write-Host "6:  Press '6' to show Path." -BackgroundColor $AltbackgroundColor
     Write-Host "7:  Press '7' to list installed drivers." -BackgroundColor $backgroundColor
     Write-Host "8:  Press '8' to show running tasks." -BackgroundColor $AltbackgroundColor
     Write-Host "9:  Press '9' to kill task." -BackgroundColor $backgroundColor
     Write-Host "10: Press '10' to display file." -BackgroundColor $AltbackgroundColor
     Write-Host "11: Press '11' for file security information." -BackgroundColor $backgroundColor
     Write-Host "12: Press '12' to show current network connections and listening ports." -BackgroundColor $AltbackgroundColor
     Write-Host "Q:  Press 'Q' to quit." -BackgroundColor $backgroundColor

}
do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
             '1' {
    "------------------HOSTNAME------------------"
    clear-host
    Write-host "Hostname:  " -NoNewline
    HOSTNAME.exe

           } '2' {
    clear-host
    "---------------IPV4 ADDRESSES---------------"
     Get-NetIPConfiguration | ft InterfaceAlias, Ipv4Address

           } '3' {
    clear-host
    "------------DNS SERVER ADDRESSES------------"
  #  (Get-NetIPConfiguration | Get-DnsClientServerAddress)
  #  (Get-NetIPConfiguration | Get-DnsClientServerAddress | format-table -auto)
    Get-DnsClientServerAddress | ft InterfaceAlias, ServerAddresses -auto

          } '4' {
    clear-host
    "--------------DEFAULT GATEWAY---------------"
    Get-NetIPConfiguration | Foreach IPv4DefaultGateway

          } '5' {
    clear-host
    $freemem = Get-WmiObject -Class Win32_OperatingSystem
    "----------------FREE MEMORY-----------------"
    ""
    "System Name     : {0}" -f $freemem.csname
    "Free Memory (MB): {0}" -f ([math]::round($freemem.FreePhysicalMemory / 1024, 2))
    "Free Memory (GB): {0}" -f ([math]::round(($freemem.FreePhysicalMemory / 1024 / 1024), 2))

          } '6' {
    clear-host
    "---------------CURRENT PATH-----------------"
    ""
    $env:path

          } '7' {
    clear-host
    "-------------INSTALLED DRIVERS--------------"
    Get-WindowsDriver -online -all

          } '8' {
    clear-host
    "---------------RUNNING TASKS----------------"
    # Live Tasks WARNING: Breaks loop
    # While(1) {ps | sort -des cpu | select -f 15 | ft -a; sleep 1; cls}
    Get-Process

          } '9' {
    clear-host
    "------------ENTER PROCESS TO KILL-----------"
# Output can be configured via the Sort variable
$Sort = "Id"
    Get-Process | Sort-Object $Sort | Format-Table Id, ProcessName
    $task = Read-Host "Enter PID of Process to Kill"
    Stop-Process $task

          } '10' {
    clear-host
      "---------------DISPLAY FILE---------------"
      ""
      $file = Read-Host "ENTER PATH OF FILE TO DISPLAY"
      Get-Content $file
          } '11' {
    clear-host
    "---------FILE SECURITY INFORMATION----------"
    ""
     $security = Read-Host "ENTER PATH OF FILE: "
    Get-Acl $security

          } '12' {
    clear-host
    "---------ACTIVE NETWORK CONNECTIONS---------"
    Get-NetTCPConnection -appliedsetting internet | Sort-Object LocalAddress| format-table -auto
           } 'q' {
    return
           }
     }
     pause
}
until ($input -eq 'q')
