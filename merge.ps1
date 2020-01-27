# Author: Drew Theis
# Date: 9/5/2019
# Description: GUI based script to allow merger of PCAP/PCAPNG files
# Version: 0.2.1
# Update: Added folder browser function
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
$form.Size = New-Object System.Drawing.Size(320,200)
$form.StartPosition = 'CenterScreen'

$okBtn = New-Object System.Windows.Forms.Button
$okBtn.Location = New-Object System.Drawing.Point(75,120)
$okBtn.Size = New-Object System.Drawing.Size(75,23)
$okBtn.Text = 'OK'
$okBtn.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okBtn
$form.Controls.Add($okBtn)

$cancelBtn = New-Object System.Windows.Forms.Button
$cancelBtn.Location = New-Object System.Drawing.Point(150,120)
$cancelBtn.Size = New-Object System.Drawing.Size(75,23)
$cancelBtn.Text = 'Cancel'
$cancelBtn.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelBtn
$form.Controls.Add($cancelBtn)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Enter file location for new merged PCAP'
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
$label2.Text = 'Enter parent folder with PCAPs to merge'
$form.Controls.Add($label2)

$locationBox = New-Object System.Windows.Forms.TextBox
$locationBox.Location = New-Object System.Drawing.Point(10,90)
$locationBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($locationBox)

$dstFolderBtn = New-Object System.Windows.Forms.Button
$dstFolderBtn.Location = New-Object System.Drawing.Point(270,90)
$dstFolderBtn.Size = New-Object System.Drawing.Size(23,20)
$dstFolderBtn.Text = "..."
$dstFolderBtn.Add_Click({$locationBox.Text = Get-Folder})
$form.Controls.Add($dstFolderBtn)

$form.Topmost = $true
$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $name = $textBox.Text
    $folder = $locationBox.Text
    $files = (Get-ChildItem -Path $folder)
    Set-Location -Path $folder
    C:\'Program Files'\Wireshark\mergecap.exe -w $name $files
    if ($files.Equals("Filter_PCAP.pcapng")) {
        Write-Host "Ignore Merged file"
    } else {
        Remove-Item $files
    }  
}