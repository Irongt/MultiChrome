Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form
$form.Text = "Crear un perfil"
$form.Size = New-Object Drawing.Size(400,610) 
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.BackColor = [Drawing.Color]::FromArgb(245, 247, 250)

$iconPath = Join-Path -Path $PSScriptRoot -ChildPath "logo.ico"
if (Test-Path $iconPath) {
    $form.icon = [System.Drawing.Icon]::FromHandle([System.Drawing.Bitmap]::FromFile($iconPath).GetHicon())
}

$fontLabel = New-Object Drawing.Font("Noto Sans JP Medium", 10, [Drawing.FontStyle]::Bold)
$fontInput = New-Object Drawing.Font("Noto Sans JP Medium", 10)
$fontTitle = New-Object Drawing.Font("Noto Sans JP Medium", 12, [Drawing.FontStyle]::Bold)

$colorFile = "color.cfg"
if (Test-Path $colorFile) {
    $colorLine = Get-Content $colorFile | Select-Object -First 1
    if ($colorLine -match '^\s*(\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3})\s*$') {
        $r = [int]$matches[1]
        $g = [int]$matches[2]
        $b = [int]$matches[3]
        $btnColor = [Drawing.Color]::FromArgb($r, $g, $b)
    } else {
        $btnColor = [Drawing.Color]::FromArgb(52, 152, 219)
    }
} else {
    $btnColor = [Drawing.Color]::FromArgb(52, 152, 219)
}

# Titulo
$lblTitulo = New-Object Windows.Forms.Label
$lblTitulo.Text = "Crear Perfil"
$lblTitulo.Location = New-Object Drawing.Point(0, 30)
$lblTitulo.Size = New-Object Drawing.Size($form.ClientSize.Width, 40)
$lblTitulo.Font = $fontTitle
$lblTitulo.TextAlign = 'MiddleCenter'
$lblTitulo.ForeColor = [Drawing.Color]::FromArgb(44, 62, 80)
$lblTitulo.Anchor = 'Top,Left,Right'

# Nombre
$lblNombre = New-Object Windows.Forms.Label
$lblNombre.Text = "Nombre"
$lblNombre.Location = New-Object Drawing.Point(40, 110)
$lblNombre.Size = New-Object Drawing.Size(100, 20)
$lblNombre.Font = $fontLabel
$lblNombre.ForeColor = [Drawing.Color]::FromArgb(52, 73, 94)

# Entrada Nombre
$txtNombre = New-Object Windows.Forms.TextBox
$txtNombre.Location = New-Object Drawing.Point(40, 135)
$txtNombre.Size = New-Object Drawing.Size(320, 25)
$txtNombre.Font = $fontInput
$txtNombre.BackColor = [Drawing.Color]::White

# PIN
$lblPIN = New-Object Windows.Forms.Label
$lblPIN.Text = "PIN"
$lblPIN.Location = New-Object Drawing.Point(40, 190)
$lblPIN.Size = New-Object Drawing.Size(100, 20)
$lblPIN.Font = $fontLabel
$lblPIN.ForeColor = [Drawing.Color]::FromArgb(52, 73, 94)

# Entrada PIN
$txtPIN = New-Object Windows.Forms.TextBox
$txtPIN.Location = New-Object Drawing.Point(40, 215)
$txtPIN.Size = New-Object Drawing.Size(320, 25)
$txtPIN.Font = $fontInput
$txtPIN.UseSystemPasswordChar = $true
$txtPIN.BackColor = [Drawing.Color]::White

# Crear perfil
$btnCrear = New-Object Windows.Forms.Button
$btnCrear.Text = "Crear Perfil"
$btnCrear.Location = New-Object Drawing.Point(110, 300)
$btnCrear.Size = New-Object Drawing.Size(180, 50)
$btnCrear.Font = $fontInput
$btnCrear.BackColor = $btnColor
$btnCrear.ForeColor = [Drawing.Color]::White
$btnCrear.FlatStyle = 'Flat'
$btnCrear.FlatAppearance.BorderSize = 0

$btnCrear.Add_MouseEnter({ $btnCrear.BackColor = [Drawing.Color]::FromArgb(41, 128, 185) })
$btnCrear.Add_MouseLeave({ $btnCrear.BackColor = $btnColor })

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

    [System.IO.File]::WriteAllText($archivo, $pin, [System.Text.Encoding]::UTF8)
    [System.Windows.Forms.MessageBox]::Show("Perfil creado con exito.", "Éxito", "OK", "Information")
    $form.Close()
})

# Boton Cancelar
$btnCancel = New-Object Windows.Forms.Button
$btnCancel.Text = "Cancelar"
$btnCancel.Location = New-Object Drawing.Point(110, 370)
$btnCancel.Size = New-Object Drawing.Size(180, 50)
$btnCancel.Font = $fontInput
$btnCancel.BackColor = [Drawing.Color]::FromArgb(200, 60, 60)
$btnCancel.ForeColor = [Drawing.Color]::White
$btnCancel.FlatStyle = 'Flat'
$btnCancel.FlatAppearance.BorderSize = 0

$btnCancel.Add_MouseEnter({ $btnCancel.BackColor = [Drawing.Color]::FromArgb(160, 40, 40) })
$btnCancel.Add_MouseLeave({ $btnCancel.BackColor = [Drawing.Color]::FromArgb(200, 60, 60) })

$btnCancel.Add_Click({
    $form.Close()
})

$form.Controls.Add($lblTitulo)
$form.Controls.Add($lblNombre)
$form.Controls.Add($txtNombre)
$form.Controls.Add($lblPIN)
$form.Controls.Add($txtPIN)
$form.Controls.Add($btnCrear)
$form.Controls.Add($btnCancel)
$form.ShowDialog()
