Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form
$form.Text = "Entrar a un perfil"
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

# Título
$lblTitulo = New-Object Windows.Forms.Label
$lblTitulo.Text = "Entrar a un perfil"
$lblTitulo.Location = New-Object Drawing.Point(0, 30)
$lblTitulo.Size = New-Object Drawing.Size($form.ClientSize.Width, 40)
$lblTitulo.Font = $fontTitle
$lblTitulo.TextAlign = 'MiddleCenter'
$lblTitulo.ForeColor = [Drawing.Color]::FromArgb(44, 62, 80)
$lblTitulo.Anchor = 'Top,Left,Right'

# Etiqueta: Nombre
$lblNombre = New-Object Windows.Forms.Label
$lblNombre.Text = "Nombre"
$lblNombre.Location = New-Object Drawing.Point(40, 110)
$lblNombre.Size = New-Object Drawing.Size(100, 20)
$lblNombre.Font = $fontLabel
$lblNombre.ForeColor = [Drawing.Color]::FromArgb(52, 73, 94)

# Entrada: Nombre
$txtNombre = New-Object Windows.Forms.TextBox
$txtNombre.Location = New-Object Drawing.Point(40, 135)
$txtNombre.Size = New-Object Drawing.Size(320, 25)
$txtNombre.Font = $fontInput
$txtNombre.BackColor = [Drawing.Color]::White

# Etiqueta: PIN
$lblPIN = New-Object Windows.Forms.Label
$lblPIN.Text = "PIN"
$lblPIN.Location = New-Object Drawing.Point(40, 190)
$lblPIN.Size = New-Object Drawing.Size(100, 20)
$lblPIN.Font = $fontLabel
$lblPIN.ForeColor = [Drawing.Color]::FromArgb(52, 73, 94)

# Entrada: PIN
$txtPIN = New-Object Windows.Forms.TextBox
$txtPIN.Location = New-Object Drawing.Point(40, 215)
$txtPIN.Size = New-Object Drawing.Size(320, 25)
$txtPIN.Font = $fontInput
$txtPIN.UseSystemPasswordChar = $true
$txtPIN.BackColor = [Drawing.Color]::White

# Botón: Continuar
$btnContinuar = New-Object Windows.Forms.Button
$btnContinuar.Text = "Continuar"
$btnContinuar.Location = New-Object Drawing.Point(110, 300)
$btnContinuar.Size = New-Object Drawing.Size(180, 50)
$btnContinuar.Font = $fontInput
$btnContinuar.BackColor = $btnColor
$btnContinuar.ForeColor = [Drawing.Color]::White
$btnContinuar.FlatStyle = 'Flat'
$btnContinuar.FlatAppearance.BorderSize = 0

$btnContinuar.Add_MouseEnter({ $btnContinuar.BackColor = [Drawing.Color]::FromArgb(41, 128, 185) })
$btnContinuar.Add_MouseLeave({ $btnContinuar.BackColor = $btnColor })

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
    Set-Content -Path "nloged.cfg" -Value "Easter egg"
    $form.Close()
})


$form.Controls.Add($lblTitulo)
$form.Controls.Add($lblNombre)
$form.Controls.Add($txtNombre)
$form.Controls.Add($lblPIN)
$form.Controls.Add($txtPIN)
$form.Controls.Add($btnContinuar)
$form.Controls.Add($btnCancel)
$form.ShowDialog()