# Author: Drew Theis
# Date: 3/23/19
# Description: Allows capture on selected interface
# Version: 0.0.1
$DATE = Get-Date -UFormat "%m-%d"
$OUTFILE = "$DATE" + ".pcapng"
C:\'Program Files'\Wireshark\dumpcap.exe -i Ethernet -b filesize:2000000 -b files:100 -w "E:\Saved PCAP\$OUTFILE"