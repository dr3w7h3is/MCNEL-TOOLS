# Author: Drew Theis
# Date: 9/5/2019
# Description: Allows filter to be applied to many .pcap/pcapng at once to speed up processing ran form terminal
# Version: 0.1.1
# Updates: Added support to check if file already exsits in destination directory to skip processing, prevent data from being over written and allows
#          for the processing to be picked up where it left off in the event of an outage.
$sourceFolder = "C:\Some\File\Location"
$destinationFolder = "C:\Some\New\File\Location"
$cap = Get-ChildItem $folder
foreach ($singleCap in $cap) {
    If ((Test-Path $destinationFolder\$singleCap) -notcontains $true ) {
        Write-Host "PCAP already processed, moving to next file"
    } else {
        Write-Host "Starting on PCAP: $singleCap"
        C:\'Program Files'\Wireshark\tshark.exe -r "$sourceFolder\$singleCap" -Y "(some.wireshark.filter)" -w "$destinationFolder\$singleCap"
        Write-Host "Finished processing PCAP: $singleCap"
    }
}