# Author: Drew Theis
# Date: 9/5/2019
# Description: Allows capture on selected interface
# Version: 0.2.2
# Update: Added folder broswer function
function Get-Folder() {
    $srcLocation = New-Object System.Windows.Forms.FolderBrowserDialog
    $srcLocation.rootfolder = "Desktop"
    $PATH = ""
    if ($srcLocation.ShowDialog() -eq "OK") {$PATH = $srcLocation.SelectedPath}
    return $PATH
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$form = New-Object System.Windows.Forms.Form
$form.Text = 'PCAP Merge'
$form.Size = New-Object System.Drawing.Size(320,260)
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
$label.Text = 'Enter save location'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)

$srcFolderBtn = New-Object System.Windows.Forms.Button
$srcFolderBtn.Location = New-Object System.Drawing.Point(270,40)
$srcFolderBtn.Size = New-Object System.Drawing.Size(23,20)
$srcFolderBtn.Text = "..."
$srcFolderBtn.Add_Click({$textBox.Text = Get-Folder})
$form.Controls.Add($srcFolderBtn)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10,70)
$label2.Size = New-Object System.Drawing.Size(280,20)
$label2.Text = 'Select Interface'
$form.Controls.Add($label2)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,90)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 80

$interface = Get-NetAdapter | Select-Object -ExpandProperty Name
for ($i = 0; $i -lt $interface.Length; $i++) {
    $listBox.Items.Add($interface[$i])
}
$form.Controls.Add($listBox)

$form.Topmost = $true
$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $folder = $textBox.Text
    $int = $listBox.SelectedItem
    $DATE = Get-Date -UFormat "%m-%d"
    $name = "$DATE" + ".pcapng"
    C:\'Program Files'\Wireshark\dumpcap.exe -i $int -b filesize:2000000 -b files:100 -w "$folder\$name"
}