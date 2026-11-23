@echo off
rem ============================================================
rem  FREEVPN - Lanzador principal
rem  Abre el menu interactivo con permisos de administrador.
rem ============================================================
setlocal
cd /d "%~dp0"

if not exist "%~dp0autovpn.exe" (
    echo.
    echo  ERROR: no se encuentra autovpn.exe en esta carpeta.
    echo  Asegurate de ejecutar este archivo desde la carpeta FREEVPN.
    echo.
    pause
    exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$exe = Join-Path '%~dp0' 'autovpn.exe';" ^
  "try { Start-Process -FilePath $exe -WorkingDirectory '%~dp0' -Verb RunAs } catch { Write-Host 'No se pudo elevar a administrador:' $_.Exception.Message; pause }"

exit /b 0
