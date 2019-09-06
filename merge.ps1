# Author: Drew Theis
# Date: 9/5/2019
# Description: GUI based script to allow merger of PCAP/PCAPNG files
# Version: 0.1.1
# Update: Added dialog box feature to take user imput
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$findFolders = {
    [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $browse.SelectedPath = "C:\"
    $browse.ShowNewFolderButton = $false
    $browse.Description = "Select a directory"

    $loop = $true
    while($loop)
    {
        if ($browse.ShowDialog() -eq "OK")
        {
        $loop = $false
		
		#Insert your script here
		
        } else
        {
            $res = [System.Windows.Forms.MessageBox]::Show("You clicked Cancel. Would you like to try again or exit?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
            if($res -eq "Cancel")
            {
                #Ends script
                return
            }
        }
    }
    $browse.SelectedPath
    $browse.Dispose()
}

$form = New-Object System.Windows.Forms.Form
$form.Text = 'PCAP Merge'
$form.Size = New-Object System.Drawing.Size(320,200)
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

$dirButton = New-Object System.Windows.Forms.Button
$dirButton.Location = New-Object System.Drawing.Point(270,40)
$dirButton.Size = New-Object System.Drawing.Size(25,20)
$dirButton.Text = '...'
$form.CancelButton = $dirButton
$form.Controls.Add($dirButton)

$dirButton.Add_Click($findFolders)

$dir2Button = New-Object System.Windows.Forms.Button
$dir2Button.Location = New-Object System.Drawing.Point(270,40)
$dir2Button.Size = New-Object System.Drawing.Size(25,20)
$dir2Button.Text = '...'
$form.CancelButton = $dir2Button
$form.Controls.Add($dir2Button)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Enter file name for the merged PCAP'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)

#$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
#$folderBrowser.Description = "Select a folder"
#$folderBrowser.RootFolder = "MyComputer"
#$folderBrowser.ShowDialog()
#$folderBrowser.SelectedPath

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
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $name = $textBox.Text
    $folder = $locationBox.Text
    $files = (Get-ChildItem -Path $folder)
    Set-Location -Path $folder
    C:\'Program Files'\Wireshark\mergecap.exe -w $name $files 
}