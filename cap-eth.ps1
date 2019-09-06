# Author: Drew Theis
# Date: 9/5/2019
# Description: Allows capture on selected interface
# Version: 0.1.1
# Update: Added UI for ease of use to the user
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'PCAP Merge'
$form.Size = New-Object System.Drawing.Size(300,300)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,180)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,180)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Enter save location'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10,70)
$label2.Size = New-Object System.Drawing.Size(280,20)
$label2.Text = 'Select Interface'
$form.Controls.Add($label2)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,90)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 80

[void] $listBox.Items.Add('Ethernet')
[void] $listBox.Items.Add('Ethernet 2')
[void] $listBox.Items.Add('Ethernet 3')
[void] $listBox.Items.Add('Ethernet 4')
[void] $listBox.Items.Add('Ethernet 5')
[void] $listBox.Items.Add('Ethernet 6')
[void] $listBox.Items.Add('Ethernet 7')
[void] $listBox.Items.Add('Ethernet 8')
[void] $listBox.Items.Add('Ethernet 9')
[void] $listBox.Items.Add('Ethernet 10')
[void] $listBox.Items.Add('Ethernet 11')
[void] $listBox.Items.Add('Ethernet 12')
[void] $listBox.Items.Add('Ethernet 13')

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