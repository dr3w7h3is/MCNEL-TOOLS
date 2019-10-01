# Author: Drew Theis
# Date: 9/5/2019
# Description: Allows filter to be applied to many .pcap/pcapng at once to speed up processing ran form terminal
# Version: 0.2.1
# Updates: Added check boxes for quick filter applications
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'PCAP Filter'
$form.Size = New-Object System.Drawing.Size(300,450)
$form.StartPosition = 'CenterScreen'

$okBtn = New-Object System.Windows.Forms.Button
$okBtn.Location = New-Object System.Drawing.Point(75,350)
$okBtn.Size = New-Object System.Drawing.Size(75,23)
$okBtn.Text = 'OK'
$okBtn.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okBtn
$form.Controls.Add($okBtn)

$cancelBtn = New-Object System.Windows.Forms.Button
$cancelBtn.Location = New-Object System.Drawing.Point(150,350)
$cancelBtn.Size = New-Object System.Drawing.Size(75,23)
$cancelBtn.Text = 'Cancel'
$cancelBtn.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelBtn
$form.Controls.Add($cancelBtn)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = "Enter the source folder"
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10,70)
$label2.Size = New-Object System.Drawing.Size(280,20)
$label2.Text = "Enter the destination folder"
$form.Controls.Add($label2)

$locationBox = New-Object System.Windows.Forms.TextBox
$locationBox.Location = New-Object System.Drawing.Point(10,90)
$locationBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($locationBox)

$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(10,120)
$label3.Size = New-Object System.Drawing.Size(280,20)
$label3.Text = 'Enter desired filter'
$form.Controls.Add($label3)

$filterBox = New-Object System.Windows.Forms.TextBox
$filterBox.Location = New-Object System.Drawing.Point(10,140)
$filterBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($filterBox)

$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(10,170)
$label4.Size = New-Object System.Drawing.Size(280,20)
$label4.Text = 'Remove Defaults'
$form.Controls.Add($label4)

$arpBox = New-Object System.Windows.Forms.CheckBox
$arpBox.UseVisualStyleBackColor = $True
$arpBox.Location = New-Object System.Drawing.Point(10,190)
$arpBox.Size = New-Object System.Drawing.Size(50,20)
$arpBox.TabIndex = 0
$arpBox.Text = "ARP"
$arpBox.Name = "!arp"
$arpBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($arpBox)

$stpBox = New-Object System.Windows.Forms.CheckBox
$stpBox.UseVisualStyleBackColor = $True
$stpBox.Location = New-Object System.Drawing.Point(70,190)
$stpBox.Size = New-Object System.Drawing.Size(50,20)
$stpBox.TabIndex = 0
$stpBox.Text = "STP"
$stpBox.Name = "!stp"
$stpBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($stpBox)

$cdpBox = New-Object System.Windows.Forms.CheckBox
$cdpBox.UseVisualStyleBackColor = $True
$cdpBox.Location = New-Object System.Drawing.Point(130,190)
$cdpBox.Size = New-Object System.Drawing.Size(50,20)
$cdpBox.TabIndex = 0
$cdpBox.Text = "CDP"
$cdpBox.Name = "!cdp"
$cdpBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($cdpBox)

$loopBox = New-Object System.Windows.Forms.CheckBox
$loopBox.UseVisualStyleBackColor = $True
$loopBox.Location = New-Object System.Drawing.Point(190,190)
$loopBox.Size = New-Object System.Drawing.Size(55,20)
$loopBox.TabIndex = 0
$loopBox.Text = "LOOP"
$loopBox.Name = "!loop"
$loopBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($loopBox)

$nbnsBox = New-Object System.Windows.Forms.CheckBox
$nbnsBox.UseVisualStyleBackColor = $True
$nbnsBox.Location = New-Object System.Drawing.Point(70,230)
$nbnsBox.Size = New-Object System.Drawing.Size(60,20)
$nbnsBox.TabIndex = 0
$nbnsBox.Text = "NBNS"
$nbnsBox.Name = "!nbns"
$nbnsBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($nbnsBox)

$ssdpBox = New-Object System.Windows.Forms.CheckBox
$ssdpBox.UseVisualStyleBackColor = $True
$ssdpBox.Location = New-Object System.Drawing.Point(10,210)
$ssdpBox.Size = New-Object System.Drawing.Size(55,20)
$ssdpBox.TabIndex = 0
$ssdpBox.Text = "SSDP"
$ssdpBox.Name = "!ssdp"
$ssdpBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($ssdpBox)

$mdnsBox = New-Object System.Windows.Forms.CheckBox
$mdnsBox.UseVisualStyleBackColor = $True
$mdnsBox.Location = New-Object System.Drawing.Point(70,210)
$mdnsBox.Size = New-Object System.Drawing.Size(58,20)
$mdnsBox.TabIndex = 0
$mdnsBox.Text = "MDNS"
$mdnsBox.Name = "!mdns"
$mdnsBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($mdnsBox)

$lldpBox = New-Object System.Windows.Forms.CheckBox
$lldpBox.UseVisualStyleBackColor = $True
$lldpBox.Location = New-Object System.Drawing.Point(130,210)
$lldpBox.Size = New-Object System.Drawing.Size(55,20)
$lldpBox.TabIndex = 0
$lldpBox.Text = "LLDP"
$lldpBox.Name = "!lldp"
$lldpBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($lldpBox)

$igmpBox = New-Object System.Windows.Forms.CheckBox
$igmpBox.UseVisualStyleBackColor = $True
$igmpBox.Location = New-Object System.Drawing.Point(190,210)
$igmpBox.Size = New-Object System.Drawing.Size(55,20)
$igmpBox.TabIndex = 0
$igmpBox.Text = "IGMP"
$igmpBox.Name = "!igmp"
$igmpBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($igmpBox)

$eigrpBox = New-Object System.Windows.Forms.CheckBox
$eigrpBox.UseVisualStyleBackColor = $True
$eigrpBox.Location = New-Object System.Drawing.Point(10,230)
$eigrpBox.Size = New-Object System.Drawing.Size(60,20)
$eigrpBox.TabIndex = 0
$eigrpBox.Text = "EIGRP"
$eigrpBox.Name = "!eigrp"
$eigrpBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($eigrpBox)

$ospfBox = New-Object System.Windows.Forms.CheckBox
$ospfBox.UseVisualStyleBackColor = $True
$ospfBox.Location = New-Object System.Drawing.Point(130,230)
$ospfBox.Size = New-Object System.Drawing.Size(60,20)
$ospfBox.TabIndex = 0
$ospfBox.Text = "OSPF"
$ospfBox.Name = "!ospf"
$ospfBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($ospfBox)

$bgpBox = New-Object System.Windows.Forms.CheckBox
$bgpBox.UseVisualStyleBackColor = $True
$bgpBox.Location = New-Object System.Drawing.Point(190,230)
$bgpBox.Size = New-Object System.Drawing.Size(60,20)
$bgpBox.TabIndex = 0
$bgpBox.Text = "BGP"
$bgpBox.Name = "!bgp"
$bgpBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($bgpBox)

$browserBox = New-Object System.Windows.Forms.CheckBox
$browserBox.UseVisualStyleBackColor = $True
$browserBox.Location = New-Object System.Drawing.Point(10,250)
$browserBox.Size = New-Object System.Drawing.Size(110,20)
$browserBox.TabIndex = 0
$browserBox.Text = "MS-BROWSER"
$browserBox.Name = "!browser"
$browserBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($browserBox)

$broadcastBox = New-Object System.Windows.Forms.CheckBox
$broadcastBox.UseVisualStyleBackColor = $True
$broadcastBox.Location = New-Object System.Drawing.Point(130,250)
$broadcastBox.Size = New-Object System.Drawing.Size(110,20)
$broadcastBox.TabIndex = 0
$broadcastBox.Text = "BROADCAST"
$broadcastBox.Name = "!ip.addr==255.255.255.255"
$broadcastBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($broadcastBox)

$label5 = New-Object System.Windows.Forms.Label
$label5.Location = New-Object System.Drawing.Point(10,280)
$label5.Size = New-Object System.Drawing.Size(280,20)
$label5.Text = 'Show Common'
$form.Controls.Add($label5)

$httpBox = New-Object System.Windows.Forms.CheckBox
$httpBox.UseVisualStyleBackColor = $True
$httpBox.Location = New-Object System.Drawing.Point(10,300)
$httpBox.Size = New-Object System.Drawing.Size(60,20)
$httpBox.TabIndex = 0
$httpBox.Text = "HTTP"
$httpBox.Name = "http"
$httpBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($httpBox)

$httpsBox = New-Object System.Windows.Forms.CheckBox
$httpsBox.UseVisualStyleBackColor = $True
$httpsBox.Location = New-Object System.Drawing.Point(70,300)
$httpsBox.Size = New-Object System.Drawing.Size(60,20)
$httpsBox.TabIndex = 0
$httpsBox.Text = "HTTPS"
$httpsBox.Name = "tcp.port==443"
$httpsBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($httpsBox)

$smbBox = New-Object System.Windows.Forms.CheckBox
$smbBox.UseVisualStyleBackColor = $True
$smbBox.Location = New-Object System.Drawing.Point(130,300)
$smbBox.Size = New-Object System.Drawing.Size(60,20)
$smbBox.TabIndex = 0
$smbBox.Text = "SMB"
$smbBox.Name = "smb"
$smbBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($smbBox)

$taniumBox = New-Object System.Windows.Forms.CheckBox
$taniumBox.UseVisualStyleBackColor = $True
$taniumBox.Location = New-Object System.Drawing.Point(190,300)
$taniumBox.Size = New-Object System.Drawing.Size(80,20)
$taniumBox.TabIndex = 0
$taniumBox.Text = "TANIUM"
$taniumBox.Name = "tcp.port==17472"
$taniumBox.DataBindings.DefaultDataSourceUpdateMode = 0
$form.Controls.Add($taniumBox)

$form.Topmost = $true
$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $source = $textBox.Text
    $destination = $locationBox.Text
    $userFilter = $filterBox.Text
    $preBuilt = ""
    Write-Host "User Defined Filter: $preFilter"
    if ($arpBox.Checked) {$preBuilt += " " + $arpBox.Name}
    if ($stpBox.Checked) {$preBuilt += " " + $stpBox.Name}
    if ($cdpBox.Checked) {$preBuilt += " " + $cdpBox.Name}
    if ($loopBox.Checked) {$preBuilt += " " + $loopBox.Name}
    if ($ssdpBox.Checked) {$preBuilt += " " + $ssdpBox.Name}
    if ($mdnsBox.Checked) {$preBuilt += " " + $mdnsBox.Name}
    if ($lldpBox.Checked) {$preBuilt += " " + $lldpBox.Name}
    if ($igmpBox.Checked) {$preBuilt += " " + $igmpBox.Name}
    if ($eigrpBox.Checked) {$preBuilt += " " + $eigrpBox.Name}
    if ($nbnsBox.Checked) {$preBuilt += " " + $nbnsBox.Name}
    if ($ospfBox.Checked) {$preBuilt += " " + $ospfBox.Name}
    if ($bgpBox.Checked) {$preBuilt += " " + $bgpBox.Name}
    if ($browserBox.Checked) {$preBuilt += " " + $browserBox.Name}
    if ($broadcastBox.Checked) {$preBuilt += " " + $broadcastBox.Name}
    if ($httpBox.Checked) {$preBuilt += " " + $httpBox.Name}
    if ($httpsBox.Checked) {$preBuilt += " " + $httpsBox.Name}
    if ($smbBox.Checked) {$preBuilt += " " + $smbBox.Name}
    if ($taniumBox.Checked) {$preBuilt += " " + $taniumBox.Name}
    $preBuilt = $preBuilt -replace '\s', ' && '
    $preBuilt = $preBuilt.TrimStart(' && ')
    Write-Host "Predefined Filters: $preBuilt"
    $filter = $preBuilt + " && " + $userFilter
    Write-Host "Filter to be used: $filter"
    $cap = Get-ChildItem $source
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
}