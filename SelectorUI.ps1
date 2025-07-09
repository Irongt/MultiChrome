Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Crear ventana principal
$form = New-Object Windows.Forms.Form
$form.Text = "Selecciona"
$form.Size = New-Object Drawing.Size(400,300)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.BackColor = 'WhiteSmoke'

# Estilo común para los botones
$buttonFont = New-Object Drawing.Font("Segoe UI", 12, [Drawing.FontStyle]::Regular)

# Botón: Entrar a un perfil
$btnEntrar = New-Object Windows.Forms.Button
$btnEntrar.Text = "Entrar a un perfil"
$btnEntrar.Size = New-Object Drawing.Size(250, 50)
$btnEntrar.Location = New-Object Drawing.Point(70, 50)
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
$btnCrear.Location = New-Object Drawing.Point(70, 120)
$btnCrear.Font = $buttonFont
$btnCrear.FlatStyle = 'Flat'

$btnCrear.Add_Click({
    Set-Content -Path "data.temp" -Value "cra"
    $form.Close()
})

# Agregar botones al formulario
$form.Controls.Add($btnEntrar)
$form.Controls.Add($btnCrear)

# Mostrar la interfaz
$form.ShowDialog()