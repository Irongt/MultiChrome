@echo off
echo Buscando Actualizacion _--
ping -n 1 google.com >nul 2>nul
if errorlevel 1 (
    color c
    echo No hay conexión a Internet.
    pause
    exit /b
)

cls
echo Buscando Actualizacion __-
curl -s https://raw.githubusercontent.com/Irongt/MultiChrome/refs/heads/main/version.txt -o latest-version.txt
set "latest_version="
for /f "tokens=*" %%b in (latest-version.txt) do set "latest_version=%%b"
if not defined latest_version (
    cls
    color c
    echo Ha ocurrido un error con la verificacion de la version
    exit /b
)

set "local_version="
for /f "tokens=*" %%a in (version.txt) do set "local_version=%%a"
if not defined local_version (
    color c
    echo Ha ocurrido un error con la verificacion de la version, asegurate de que existe version.txt
    exit /b
)

if "%local_version%" lss "%latest_version%" (
    goto newactu
) else (
    color a
    cls
    echo MultiChrome esta actualizado a la ultima version %local_version%
    pause
    exit /b
)

:newactu
color a
cls
echo Nueva Actualizacion disponible
pause
start https://github.com/Irongt/MultiChrome
exit /b
