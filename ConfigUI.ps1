Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form
$form.Text = "MultiChrome"
$form.Size = New-Object Drawing.Size(400,610)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.BackColor = 'WhiteSmoke'
$iconPath = Join-Path -Path $PSScriptRoot -ChildPath "logo.ico"
$form.icon = [System.Drawing.Icon]::FromHandle([System.Drawing.Bitmap]::FromFile($iconPath).GetHicon())
$buttonFont = New-Object Drawing.Font("Noto Sans JP Black", 12, [Drawing.FontStyle]::Regular)

# Logo
$currentDir = Get-Location
$imagePath = "$currentDir\logo256x256.png"
$Logo = New-Object System.Windows.Forms.PictureBox
$Logo.Size = New-Object System.Drawing.Size(260, 260)
$Logo.Location = New-Object System.Drawing.Point(67, 25)
$Logo.Image = [System.Drawing.Image]::FromFile($imagePath)


# Boton Eliminar Perfil
$btnConf = New-Object Windows.Forms.Button
$btnConf.Text = "Eliminar un perfil"
$btnConf.Size = New-Object Drawing.Size(250, 50)
$btnConf.Location = New-Object Drawing.Point(70, 310)
$btnConf.Font = $buttonFont
$btnConf.FlatStyle = 'Flat'
$btnConf.Add_Click({
    Set-Content -Path "data.temp" -Value "perf"
    $form.Close()
})

# Boton Cambiar tema
$btnTema = New-Object Windows.Forms.Button
$btnTema.Text = "Cambiar Tema"
$btnTema.Size = New-Object Drawing.Size(250, 50)
$btnTema.Location = New-Object Drawing.Point(70, 380)
$btnTema.Font = $buttonFont
$btnTema.FlatStyle = 'Flat'
$btnTema.Add_Click({
    Set-Content -Path "data.temp" -Value "tema"
    $form.Close()
})

# Boton Actualizar
$btnActu = New-Object Windows.Forms.Button
$btnActu.Text = "Buscar Actulizaciones"
$btnActu.Size = New-Object Drawing.Size(250, 50)
$btnActu.Location = New-Object Drawing.Point(70, 450)
$btnActu.Font = $buttonFont
$btnActu.FlatStyle = 'Flat'
$btnActu.Add_Click({
    Set-Content -Path "data.temp" -Value "actu"
    $form.Close()
})

$form.Controls.Add($btnActu)
$form.Controls.Add($btnTema)
$form.Controls.Add($btnConf)
$form.Controls.Add($Logo)
$form.ShowDialog()