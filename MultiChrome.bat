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
if "%mode%"=="non" goto ini

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

goto startchrome

:create
powershell -ExecutionPolicy Bypass -File "CreateUI.ps1"
goto ini

:startchrome
:: Obtener nombre de usuario desde loged.cfg
set "user="
for /f "delims=" %%a in (loged.cfg) do (
    set "user=%%a"
)

:: Verificación adicional para evitar errores
if not defined user (
    echo Error: El nombre de usuario no se pudo obtener desde loged.cfg
    pause
    exit
)

:: Definir ruta personalizada de perfil
set "perfil_base=%LOCALAPPDATA%\Google\Chrome"
set "user_data_dir=%perfil_base%\%user%"

:: Asegurarse de que la carpeta base existe
if not exist "%user_data_dir%" (
    mkdir "%user_data_dir%"
)

:: Iniciar Chrome con perfil personalizado
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" ^
    --user-data-dir="%user_data_dir%" ^
    --profile-directory="%user%"

:: Limpieza de archivos temporales
del /q loged.cfg 2>nul
del /q nloged.cfg 2>nul
exit
