# Author: Drew Theis
# Date: 1/19/2020
# Description: Allows filter to be applied to many .pcap/pcapng at once to speed up processing ran form terminal
# Version: 0.4.5
# Updates: Added loops for creating check objects
function Get-Folder() {
    $srcLocation = New-Object System.Windows.Forms.FolderBrowserDialog
    $srcLocation.rootfolder = "Desktop"
    $PATH = ""
    if ($srcLocation.ShowDialog() -eq "OK") {$PATH = $srcLocation.SelectedPath}
    return $PATH
}
#
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
#
$removeArr = $arpBox , $stpBox, $cdpBox, $loopBox, $ssdpBox, $mdnsBox, $lldpBox, $igmpBox, $eigrpBox, $nbns, $ospfBox, 
             $bgpBox, $udldBox, $pimBox, $icmpBox, $ipv6Box, $msbBox, $broadcastBox
$removeText = "ARP", "STP", "CDP", "LOOP", "SSDP", "MDNS", "LLDP", "IGMP", "EIGRP", "NBNS", "OSPF", "BGP", "UDLD", "PIM", 
              "ICMP", "IPv6", "MS-B", "BRCST"
$removeName = "!arp", "!stp", "!cdp", "!loop", "!ssdp", "!mdns", "!lldp", "!igmp", "!eigrp", "!nbns", "!ospf", "!bgp", 
              "!udld", "!pim", "!icmp", "!ipv6", "!browser", "!ip.addr==255.255.255.255"
$addArr = $httpBox , $httpsBox, $smbBox, $TaniumBox, $vmfBox, $cstBox, $shmcBox, $gcssBox, $dnsBox, $rdpBox, $rpcBox, 
          $proxyBox, $sshBox, $ftpBox, $smtpBox, $telnetBox, $snmpBox, $imapBox, $popBox, $ntpBox, $jreapBox, $ldapBox, 
          $syslogBox, $kerberosBox, $ocspBox, $acasBox
$addText = "HTTP", "HTTPS", "SMB", "LOOP", "TANIUM", "VMF", "CST", "SHMC", "GCSS", "DNS", "RDP", "RPC", "PROXY", "SSH",
           "FTP", "SMTP", "Telnet", "SNMP", "IMAP", "POP", "NTP", "JREAP", "LDAP", "SYSLOG", "Kerberos", "OCSP", "ACAS"
$addName = "http", "tcp.port==443", "smb", "tcp.port==17472", "tcp.port==1581", "tcp.port==9119", "tcp.port==7810 || tcp.port==7870", 
           "ip.addr==?.?.?.?", "dns", "rdp", "rpc || dcerpc", "tcp.port==8080 || tcp.port==8443", "ssh", "ftp || ftp-data", "smtp", 
           "telnet", "snmp", "imap", "pop", "ntp", "tcp.port==7002 || udp.port==7002", "ldap", "syslog", "kerberos", "ocsp", 
           "tcp.port==62 || udp.port==62"
# Creates dialog box
$form = New-Object System.Windows.Forms.Form
$form.Text = 'PCAP Filter'
$form.Size = New-Object System.Drawing.Size(320,550)
$form.StartPosition = 'CenterScreen'
# Creates OK button
$okBtn = New-Object System.Windows.Forms.Button
$okBtn.Location = New-Object System.Drawing.Point(75,470)
$okBtn.Size = New-Object System.Drawing.Size(75,23)
$okBtn.Text = 'OK'
$okBtn.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okBtn
$form.Controls.Add($okBtn)
# Creates Cancel button
$cancelBtn = New-Object System.Windows.Forms.Button
$cancelBtn.Location = New-Object System.Drawing.Point(150,470)
$cancelBtn.Size = New-Object System.Drawing.Size(75,23)
$cancelBtn.Text = 'Cancel'
$cancelBtn.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelBtn
$form.Controls.Add($cancelBtn)
# Label and text box for source location of PCAP's to process
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point($c1,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = "Enter the source folder"
$form.Controls.Add($label)
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point($c1,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)
$srcFolderBtn = New-Object System.Windows.Forms.Button
$srcFolderBtn.Location = New-Object System.Drawing.Point(270,40)
$srcFolderBtn.Size = New-Object System.Drawing.Size(23,20)
$srcFolderBtn.Text = "..."
$srcFolderBtn.Add_Click({$textBox.Text = Get-Folder})
$form.Controls.Add($srcFolderBtn)
# Label and text box for destination of processed PCAP files
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point($c1,70)
$label2.Size = New-Object System.Drawing.Size(280,20)
$label2.Text = "Enter the destination folder"
$form.Controls.Add($label2)
$locationBox = New-Object System.Windows.Forms.TextBox
$locationBox.Location = New-Object System.Drawing.Point($c1,90)
$locationBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($locationBox)
$dstFolderBtn = New-Object System.Windows.Forms.Button
$dstFolderBtn.Location = New-Object System.Drawing.Point(270,90)
$dstFolderBtn.Size = New-Object System.Drawing.Size(23,20)
$dstFolderBtn.Text = "..."
$dstFolderBtn.Add_Click({$locationBox.Text = Get-Folder})
$form.Controls.Add($dstFolderBtn)
# Label and text box for User defined filters
$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point($c1,120)
$label3.Size = New-Object System.Drawing.Size(280,20)
$label3.Text = 'Enter desired filter'
$form.Controls.Add($label3)
$filterBox = New-Object System.Windows.Forms.TextBox
$filterBox.Location = New-Object System.Drawing.Point($c1,140)
$filterBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($filterBox)
# Label to inform user of check boxes to remove unwanted protocols
$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point($c1,170)
$label4.Size = New-Object System.Drawing.Size(280,20)
$label4.Text = 'Remove Defaults'
$form.Controls.Add($label4)
# Label to filter on selected wanted protocols
$label5 = New-Object System.Windows.Forms.Label
$label5.Location = New-Object System.Drawing.Point(10,300)
$label5.Size = New-Object System.Drawing.Size(280,20)
$label5.Text = 'Show Common'
$form.Controls.Add($label5)
#
$col = 10
$row = 190
for ($i = 0; $i -lt $removeArr.length; $i++) {
    if ($col -ge 210) {
        $col = 10 
        $row += 20
    }
    $removeArr[$i] = New-Object System.Windows.Forms.CheckBox
    $removeArr[$i].Location = New-Object System.Drawing.Point($col,$row)
    $removeArr[$i].Size = New-Object System.Drawing.Size(65,20)
    $removeArr[$i].Text = $removeText[$i]
    $removeArr[$i].Name = $removeName[$i]
    $form.Controls.Add($removeArr[$i])
    $col += 65
}
$col2 = 10
$row2 = 320
for ($i = 0; $i -lt $addArr.length; $i++) {
    if ($col2 -ge 230) {
        $col2 = 10
        $row2 += 20
    }
    $addArr[$i] = New-Object System.Windows.Forms.CheckBox
    $addArr[$i].Location = New-Object System.Drawing.Point($col2,$row2)
    $addArr[$i].Size = New-Object System.Drawing.Size(70,20)
    $addArr[$i].Text = $addText[$i]
    $addArr[$i].Name = $addName[$i]
    $form.Controls.Add($addArr[$i])
    $col2 += 70  
}
$form.Topmost = $true
$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()
# Condition statement to run when OK button is pressed
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $source = $textBox.Text
    $destination = $locationBox.Text
    $userFilter = $filterBox.Text
    # String for protocols of stuff to remove
    $preBuilt = ""
    $keepFilter = ""
    for ($i = 0; $i -lt $removeArr.Length; $i++) {if ($removeArr[$i].Checked) {$preBuilt += " " + $removeArr[$i].Name}}
    for ($i = 0; $i -lt $addArr.Length; $i++) {if ($addArr[$i].Checked) {$keepFilter += "_" + $addArr[$i].Name}}
    $preBuilt = $preBuilt -replace '\s', ' && '
    $preBuilt = $preBuilt.TrimStart(' && ')
    $keepFilter = $keepFilter -replace '_', ' || '
    $keepFilter = $keepFilter.TrimStart(' || ')
    # IF statements to evaluate String type
    if (!$userFilter.Equals("") -and !$preBuilt.Equals("") -and !$keepFilter.Equals("")) {
        $filter = "($preBuilt) && ($userFilter) || ($keepFilter)" 
    } elseif (!$userFilter.Equals("") -and !$preBuilt.Equals("") -and $keepFilter.Equals("")) {
        $filter = "($preBuilt) && ($userFilter)" 
    } elseif (!$userFilter.Equals("") -and $preBuilt.Equals("") -and !$keepFilter.Equals("")) {
        $filter = "($userFilter) || ($keepFilter)" 
    } elseif ($userFilter.Equals("") -and !$preBuilt.Equals("") -and !$keepFilter.Equals("")) {
        $filter = "($preBuilt) && ($keepFilter)" 
    } elseif (!$userFilter.Equals("") -and $preBuilt.Equals("") -and $keepFilter.Equals("")) {
        $filter = "($userFilter)" 
    } elseif ($userFilter.Equals("") -and !$preBuilt.Equals("") -and $keepFilter.Equals("")) {
        $filter = "($preBuilt)" 
    } elseif ($userFilter.Equals("") -and $preBuilt.Equals("") -and !$keepFilter.Equals("")) {
        $filter = "($keepFilter)" 
    } elseif ($userFilter.Equals("") -and $preBuilt.Equals("") -and $keepFilter.Equals("")) {
        $filter = "" 
    } else {
        Write-Host "An error has occured"
    }
    # Output to user to show what they have entered
    Write-Host "User Defined Filter: $preFilter"
    Write-Host "Predefined Filters: $preBuilt"
    Write-Host "Filter to be used: $filter"
    # Gets all items in folder
    $cap = Get-ChildItem $source
    # Loop to check if files have already been processed and run Tshark
    foreach ($singleCap in $cap) {
       If ((Test-Path $destination\$singleCap) -notcontains $false ) {
            Write-Host "PCAP already processed, moving to next file"
        } else {
            Write-Host "Starting on PCAP: $singleCap"
            #D:\Wireshark\tshark.exe -r "$source\$singleCap" -Y "$filter" -w "$destination\$singleCap"
            C:\'Program Files'\Wireshark\tshark.exe -r "$source\$singleCap" -Y "$filter" -w "$destination\$singleCap"
            Write-Host "Finished processing PCAP: $singleCap"
        }
    }
    $files = (Get-ChildItem -Path $destination)
    Set-Location -Path $destination
    C:\'Program Files'\Wireshark\mergecap.exe -w "$destination\Filter_PCAP.pcapng" $files
    if ($files.Equals("Filter_PCAP.pcapng")) {
        Write-Host "Ignore Merged file"
    } else {
        Write-Host "Deleting $files after merge"
        Remove-Item $files
    } 
}