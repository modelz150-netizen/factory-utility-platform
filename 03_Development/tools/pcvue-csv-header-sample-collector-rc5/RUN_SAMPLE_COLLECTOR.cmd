@echo off
setlocal
set "POWERSHELL_EXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
if not exist "%POWERSHELL_EXE%" exit /b 10
pushd "%~dp0" || exit /b 11
set "PACKAGE_ROOT=%CD%"
set "CHECKER=%CD%\Check-SampleCollector.ps1"
set "COLLECTOR=%CD%\Collect-PCVueCsvHeaders.ps1"
if not defined SAMPLE_OUTPUT_ROOT set "SAMPLE_OUTPUT_ROOT=%CD%\Sample_Output"
"%POWERSHELL_EXE%" -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "%CHECKER%" -PackageRoot "%PACKAGE_ROOT%"
if errorlevel 1 goto :failed
"%POWERSHELL_EXE%" -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "%COLLECTOR%" -OutputRoot "%SAMPLE_OUTPUT_ROOT%" -ConfigPath "%CD%\SampleConfig.psd1" %*
set "RC=%ERRORLEVEL%"
popd
exit /b %RC%
:failed
set "RC=%ERRORLEVEL%"
popd
exit /b %RC%
