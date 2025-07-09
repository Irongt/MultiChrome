Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Crear formulario
$form = New-Object Windows.Forms.Form
$form.Text = "Crear un perfil"
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
$txtPIN.UseSystemPasswordChar = $true

# Botón: Crear perfil
$btnCrear = New-Object Windows.Forms.Button
$btnCrear.Text = "Crear Perfil"
$btnCrear.Location = New-Object Drawing.Point(140, 160)
$btnCrear.Size = New-Object Drawing.Size(100, 35)
$btnCrear.Font = $fontInput

$btnCrear.Add_Click({
    $nombre = $txtNombre.Text.Trim()
    $pin = $txtPIN.Text.Trim()
    $archivo = "$nombre.dt"

    if ($nombre -eq "" -or $pin -eq "") {
        [System.Windows.Forms.MessageBox]::Show("Completa todos los campos.", "Error", "OK", "Error")
        return
    }

    if (Test-Path $archivo) {
        [System.Windows.Forms.MessageBox]::Show("Este usuario ya existe.", "Error", "OK", "Error")
        return
    }

    # Guardar PIN en archivo
    [System.IO.File]::WriteAllText($archivo, $pin, [System.Text.Encoding]::UTF8)
    [System.Windows.Forms.MessageBox]::Show("Perfil creado con éxito.", "Éxito", "OK", "Information")
    $form.Close()
})

# Añadir controles al formulario
$form.Controls.Add($lblNombre)
$form.Controls.Add($txtNombre)
$form.Controls.Add($lblPIN)
$form.Controls.Add($txtPIN)
$form.Controls.Add($btnCrear)

# Mostrar formulario
$form.ShowDialog()
