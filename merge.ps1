# Author: Drew Theis
# Date: 9/5/2019
# Description: Terminal base script to allow merger of many files
# Version: 0.1.1
# Update: Added dialog box feature to take user imput
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Data Entry Form'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please enter the file name for the merge:'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10,70)
$label2.Size = New-Object System.Drawing.Size(280,20)
$label2.Text = 'Enter parent folder with PCAPs to merge'
$form.Controls.Add($label2)

$locationBox = New-Object System.Windows.Forms.TextBox
$locationBox.Location = New-Object System.Drawing.Point(10,90)
$locationBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($locationBox)

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$form.Add_Shown({$locationBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $name = $textBox.Text
    $folder = $locationBox.Text
    $files = (Get-ChildItem -Path $folder)
    Set-Location -Path $folder
    C:\'Program Files'\Wireshark\mergecap.exe -w $name $files 
}