@echo off
setlocal
set "POWERSHELL_EXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
if not exist "%POWERSHELL_EXE%" exit /b 10
pushd "%~dp0" || exit /b 11
set "PACKAGE_ROOT=%CD%"
if not defined PILOT_OUTPUT_ROOT set "PILOT_OUTPUT_ROOT=%CD%\Pilot_Output"
"%POWERSHELL_EXE%" -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "%CD%\Check-PilotCollector.ps1" -PackageRoot "%PACKAGE_ROOT%"
if errorlevel 1 goto :failed
"%POWERSHELL_EXE%" -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "%CD%\Collect-LimitedVarexpTags.ps1" -OutputRoot "%PILOT_OUTPUT_ROOT%" -ConfigPath "%CD%\PilotConfig.psd1" %*
set "RC=%ERRORLEVEL%"
popd
exit /b %RC%
:failed
set "RC=%ERRORLEVEL%"
popd
exit /b %RC%
