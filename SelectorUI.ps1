Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Crear ventana principal
$form = New-Object Windows.Forms.Form
$form.Text = "MultiChrome"
$form.Size = New-Object Drawing.Size(400,610) # Resolucion de la ventana
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.BackColor = 'WhiteSmoke'
$iconPath = Join-Path -Path $PSScriptRoot -ChildPath "logo.ico"  # Ruta del ico
$form.icon = [System.Drawing.Icon]::FromHandle([System.Drawing.Bitmap]::FromFile($iconPath).GetHicon())
$buttonFont = New-Object Drawing.Font("Noto Sans JP Black", 12, [Drawing.FontStyle]::Regular) # Fuente de texto

# Logo
$currentDir = Get-Location
$imagePath = "$currentDir\logo256x256.png"
$Logo = New-Object System.Windows.Forms.PictureBox
$Logo.Size = New-Object System.Drawing.Size(260, 260)
$Logo.Location = New-Object System.Drawing.Point(67, 25)
$Logo.Image = [System.Drawing.Image]::FromFile($imagePath)


# Botón: Entrar a un perfil
$btnEntrar = New-Object Windows.Forms.Button
$btnEntrar.Text = "Entrar a un perfil"
$btnEntrar.Size = New-Object Drawing.Size(250, 50)
$btnEntrar.Location = New-Object Drawing.Point(70, 310)
$btnEntrar.Font = $buttonFont
$btnEntrar.FlatStyle = 'Flat'

$btnEntrar.Add_Click({
    Set-Content -Path "data.temp" -Value "ent"
    $form.Close()
})

# Botón: Crear un perfil
$btnCrear = New-Object Windows.Forms.Button
$btnCrear.Text = "Crear un perfil"
$btnCrear.Size = New-Object Drawing.Size(250, 50)
$btnCrear.Location = New-Object Drawing.Point(70, 380)
$btnCrear.Font = $buttonFont
$btnCrear.FlatStyle = 'Flat'

$btnCrear.Add_Click({
    Set-Content -Path "data.temp" -Value "cra"
    $form.Close()
})

# Botón: Configuracion
$btnConf = New-Object Windows.Forms.Button
$btnConf.Text = "Configuracion"
$btnConf.Size = New-Object Drawing.Size(250, 50)
$btnConf.Location = New-Object Drawing.Point(70, 450)
$btnConf.Font = $buttonFont
$btnConf.FlatStyle = 'Flat'

$btnConf.Add_Click({
    Set-Content -Path "data.temp" -Value "con"
    $form.Close()
})

# Agregar botones al formulario
$form.Controls.Add($btnEntrar)
$form.Controls.Add($btnCrear)
$form.Controls.Add($btnConf)
$form.Controls.Add($Logo)

# Mostrar la interfaz
$form.ShowDialog()