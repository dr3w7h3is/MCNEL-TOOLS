# Author: Drew Theis
# Date: 9/5/2019
# Description: Terminal base script to allow merger of many files
# Version: 0.0.3
# Update: Allow user to name merged PCAP
$folder = "C:\Some\File\Location"
$name = Read-Host -Prompt "Input file name: "
$files = (Get-ChildItem -Path $folder)
Set-Location -Path $folder
C:\'Program Files'\Wireshark\mergecap.exe -w $name $files 