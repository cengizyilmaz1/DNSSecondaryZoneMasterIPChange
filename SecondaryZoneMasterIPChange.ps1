<#
=============================================================================================
Name = Cengiz YILMAZ
Date = 5.5.2023
www.cengizyilmaz.net
www.cozumpark.com/author/cengizyilmaz
============================================================================================
#>

# IP Address Change
$oldMasterIP = "192.168.1.1" 
$newMasterIP = "192.168.1.10" 

# DNS Server Module Installer
Import-Module DnsServer

# All Secondary DNS Zone
$zones = Get-DnsServerZone | Where-Object { $_.ZoneType -eq "Secondary" }

foreach ($zone in $zones) {
    # Master Server IP Address Change
    $currentMasters = $zone.MasterServers
    $updatedMasters = $currentMasters | ForEach-Object {
        if ($_ -eq $oldMasterIP) {
            $newMasterIP
        } else {
            $_
        }
    }
    Set-DnsServerSecondaryZone -Name $zone.ZoneName -MasterServers $updatedMasters
}

Write-Host "Okey!"
