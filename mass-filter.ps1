# Author: Drew Theis
# Date: 9/5/2019
# Description: Allows filter to be applied to many .pcap/pcapng at once to speed up processing ran form terminal
# Version: 0.1.2
# Updates: Added UI for ease of use
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'PCAP Filter'
$form.Size = New-Object System.Drawing.Size(300,300)
$form.StartPosition = 'CenterScreen'

$okBtn = New-Object System.Windows.Forms.Button
$okBtn.Location = New-Object System.Drawing.Point(75,180)
$okBtn.Size = New-Object System.Drawing.Size(75,23)
$okBtn.Text = 'OK'
$okBtn.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okBtn
$form.Controls.Add($okBtn)

$cancelBtn = New-Object System.Windows.Forms.Button
$cancelBtn.Location = New-Object System.Drawing.Point(150,180)
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

$form.Topmost = $true
$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $source = $textBox.Text
    $destination = $locationBox.Text
    $filter = $filterBox.Text
    $cap = Get-ChildItem $source
    foreach ($singleCap in $cap) {
        If ((Test-Path $destination\$singleCap) -notcontains $false ) {
            Write-Host "PCAP already processed, moving to next file"
        } else {
            Write-Host "Starting on PCAP: $singleCap"
            C:\'Program Files'\Wireshark\tshark.exe -r "$source\$singleCap" -Y "$filter" -w "$destination\$singleCap"
            Write-Host "Finished processing PCAP: $singleCap"
        }
    }
}