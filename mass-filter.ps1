# Author: Drew Theis
# Date: 2/16/19
# Description: Allows filter to be applied to many .pcap/pcapng at once to speed up processing ran form terminal
# Version: 0.1.1
# Updates: Added support to check if file already exsits in destination directory to skip processing, prevent data from being over written and allows
# for the processing to be picked up where it left off in the event of an outage.
$sourceFolder = "E:\MCICOM 2019-8-22\MCFMIS\Server\0822_MCFIMIS_Server_BLDG33302_TR1\DP-B To MLX16"
$destinationFolder = "E:\MCICOM 2019-8-22\MCFMIS\Server\FilterToOnlyServer\Test Run 1 - 33 Area Chow hall\TAP B"
$cap = Get-ChildItem $folder
foreach ($singleCap in $cap) {
    If ((Test-Path $destinationFolder\$singleCap) -notcontains $true ) {
        Write-Host "PCAP already processed, moving to next file"
    } else {
        Write-Host "Starting on PCAP: $singleCap  From: $sourceFolder"
        C:\'Program Files'\Wireshark\tshark.exe -r "$sourceFolder\$singleCap" -Y "(some.wireshark.filter)" -w "$destinationFolder\$singleCap"
        Write-Host "Finished processing PCAP: $singleCap"
    }
}