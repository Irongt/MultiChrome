@echo off
setlocal enabledelayedexpansion

:ini
echo non > data.temp
powershell -ExecutionPolicy Bypass -File "SelectorUI.ps1"

set "mode="
for /f "delims=" %%a in (data.temp) do (
    set "mode=%%a"
)

if "%mode%"=="cra" goto create
if "%mode%"=="ent" goto login
if "%mode%"=="con" goto config
if "%mode%"=="non" goto exit

exit

:login
if exist loged.cfg del /q loged.cfg
if exist nloged.cfg del /q nloged.cfg
powershell -ExecutionPolicy Bypass -File "LoginUI.ps1"
if exist nloged.cfg (
    exit
)

if not exist loged.cfg (
    goto login
)

if "%mode%"=="ent" goto startchrome
if "%mode%"=="perf" goto eraseuser

:create
powershell -ExecutionPolicy Bypass -File "CreateUI.ps1"
goto ini

:config
powershell -ExecutionPolicy Bypass -File "ConfigUI.ps1"
set "mode="
for /f "delims=" %%a in (data.temp) do (
    set "mode=%%a"
)

if "%mode%"=="tema" (
    start https://github.com/Irongt/MultiChrome/tree/main?tab=readme-ov-file#personalizar-tema
    exit
)

if "%mode%"=="actu" (
    start ActuHelper.bat
    exit
)

if "%mode%"=="perf" goto login

:startchrome
set "user="
for /f "delims=" %%a in (loged.cfg) do (
    set "user=%%a"
)

if not defined user (
    powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Error de autenticacion', 'Error', 'OK', 'Error')"
    exit
)

set "perfil_base=%LOCALAPPDATA%\Google\Chrome"
set "user_data_dir=%perfil_base%\%user%"

if not exist "%user_data_dir%" (
    mkdir "%user_data_dir%"
)

start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" ^
    --user-data-dir="%user_data_dir%" ^
    --profile-directory="%user%"

del /q loged.cfg 2>nul
del /q nloged.cfg 2>nul

goto exit

:eraseuser
set "user="
for /f "delims=" %%a in (loged.cfg) do (
    set "user=%%a"
)

if not defined user (
    powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Error al eliminar perfil', 'Error', 'OK', 'Error')"
    goto ini
)

set "perfil_base=%LOCALAPPDATA%\Google\Chrome"
set "user_data_dir=%perfil_base%\%user%"

if not exist "%user_data_dir%" (
    powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('El perfil ya esta eliminado.', 'Info', 'OK', 'Information')"
    goto exit
)

rmdir /s /q "%user_data_dir%"
del /q data.temp 2>nul
del /q loged.cfg 2>nul
del /q nloged.cfg 2>nul

if exist "%user_data_dir%" (
    powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Error al eliminar perfil', 'Error', 'OK', 'Error')"
    goto ini ) else (del /q %user%.dt 2>nul
    powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Perfil eliminado exitosamente.', 'Exito', 'OK', 'Information')"
    goto ini
    )

:exit
del /q data.temp 2>nul
del /q loged.cfg 2>nul
del /q nloged.cfg 2>nul
exit
