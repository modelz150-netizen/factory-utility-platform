@echo off
setlocal
cd /d "%~dp0"
if not exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
  echo [FAILED] Windows PowerShell 5.1 was not found.
  exit /b 10
)
echo PCVue Offline Data Collector V1
echo Read-only collection. No elevation, UI automation, database query, or control write.
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "%~dp0Collector.ps1" %*
set "RC=%ERRORLEVEL%"
echo.
echo Collector exit code: %RC%
if not "%RC%"=="0" pause
exit /b %RC%
