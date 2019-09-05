# Author: Drew Theis
# Date: 9/5/2019
# Description: Terminal base script to allow merger of many files
# Version: 0.0.2
# Update: Fixed bug issue that would identify file as not exsisting if directory wasn't changed to source path
$folder = "C:\Some\File\Location"
$files = (Get-ChildItem -Path $folder)
Set-Location -Path $folder
C:\'Program Files'\Wireshark\mergecap.exe -w merge.pcap $files 