Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Crear formulario
$form = New-Object Windows.Forms.Form
$form.Text = "Entrar a un perfil"
$form.Size = New-Object Drawing.Size(400,300)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.BackColor = 'WhiteSmoke'

$fontLabel = New-Object Drawing.Font("Segoe UI", 10)
$fontInput = New-Object Drawing.Font("Segoe UI", 10)

# Etiqueta: Nombre
$lblNombre = New-Object Windows.Forms.Label
$lblNombre.Text = "Nombre"
$lblNombre.Location = New-Object Drawing.Point(30, 30)
$lblNombre.Size = New-Object Drawing.Size(100, 20)
$lblNombre.Font = $fontLabel

# Entrada: Nombre
$txtNombre = New-Object Windows.Forms.TextBox
$txtNombre.Location = New-Object Drawing.Point(30, 50)
$txtNombre.Size = New-Object Drawing.Size(320, 25)
$txtNombre.Font = $fontInput

# Etiqueta: PIN
$lblPIN = New-Object Windows.Forms.Label
$lblPIN.Text = "PIN"
$lblPIN.Location = New-Object Drawing.Point(30, 90)
$lblPIN.Size = New-Object Drawing.Size(100, 20)
$lblPIN.Font = $fontLabel

# Entrada: PIN
$txtPIN = New-Object Windows.Forms.TextBox
$txtPIN.Location = New-Object Drawing.Point(30, 110)
$txtPIN.Size = New-Object Drawing.Size(320, 25)
$txtPIN.Font = $fontInput
$txtPIN.UseSystemPasswordChar = $true  # oculta el texto como contraseña

# Botón: Continuar
$btnContinuar = New-Object Windows.Forms.Button
$btnContinuar.Text = "Continuar"
$btnContinuar.Location = New-Object Drawing.Point(140, 160)
$btnContinuar.Size = New-Object Drawing.Size(100, 35)
$btnContinuar.Font = $fontInput

$btnContinuar.Add_Click({
    $nombre = $txtNombre.Text.Trim()
    $pin = $txtPIN.Text.Trim()
    $archivo = "$nombre.dt"

    if (-not (Test-Path $archivo)) {
        [System.Windows.Forms.MessageBox]::Show("PIN o Usuario Incorrecto", "Error", "OK", "Error")
        return
    }

    $contenido = Get-Content $archivo -Raw
    if ($contenido -ne $pin) {
        [System.Windows.Forms.MessageBox]::Show("PIN o Usuario Incorrecto", "Error", "OK", "Error")
        return
    }

    Set-Content -Path "loged.cfg" -Value "$nombre"
    $form.Close()
})

# Botón: Cancelar
$btnCancel = New-Object Windows.Forms.Button
$btnCancel.Text = "Cancelar"
$btnCancel.Location = New-Object Drawing.Point(140, 200)
$btnCancel.Size = New-Object Drawing.Size(100, 35)
$btnCancel.Font = $fontInput

$btnCancel.Add_Click({
    Set-Content -Path "nloged.cfg" -Value "Easter egg"
    $form.Close()
})

# Añadir controles al formulario
$form.Controls.Add($lblNombre)
$form.Controls.Add($txtNombre)
$form.Controls.Add($lblPIN)
$form.Controls.Add($txtPIN)
$form.Controls.Add($btnContinuar)
$form.Controls.Add($btnCancel)

# Mostrar formulario
$form.ShowDialog()
