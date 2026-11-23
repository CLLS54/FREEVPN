@echo off
rem ============================================================
rem  FREEVPN - Instalacion del cliente SoftEther (una sola vez)
rem  Instala el cliente oficial, registra el servicio y crea
rem  el adaptador virtual con el driver WHQL (sin Error 31).
rem ============================================================
setlocal
cd /d "%~dp0"

set "INST=%~dp0instaladores\softether-vpnclient-5.2.5187.x64.exe"

if not exist "%INST%" (
    echo.
    echo  ERROR: falta el instalador en:
    echo    %INST%
    echo.
    echo  Descargalo de https://www.softether.org/ y dejalo en la
    echo  carpeta "instaladores" con ese mismo nombre.
    echo.
    pause
    exit /b 1
)

echo.
echo  Instalando SoftEther + adaptador virtual. Esto puede tardar 1-2 minutos...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$exe = Join-Path '%~dp0' 'autovpn.exe';" ^
  "$log = Join-Path '%~dp0' 'instalacion.log';" ^
  "Start-Process -FilePath $exe -ArgumentList @('setup','--installer','%INST%') -WorkingDirectory '%~dp0' -Verb RunAs -Wait;" ^
  "Write-Host ''; Write-Host 'Proceso de instalacion finalizado.'"

echo.
echo  Comprueba el resultado con FREEVPN.bat, opcion 1 (doctor).
echo.
pause
