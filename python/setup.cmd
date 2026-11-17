@echo off
rem One-step setup: virtualenv, dependencies, optional API key. Then run: run-tests.cmd
rem Run from anywhere:  setup.cmd      (Windows cmd or PowerShell)
setlocal EnableExtensions
cd /d "%~dp0"

set "PY="
where py >nul 2>&1
if not errorlevel 1 set "PY=py -3"
if not defined PY (
  where python >nul 2>&1
  if not errorlevel 1 set "PY=python"
)
if not defined PY (
  echo Python not found. Install Python 3.10 or newer from python.org, then re-run. 1>&2
  exit /b 1
)

echo ==^> Creating virtualenv (.venv) and installing dependencies...
if not exist ".venv\Scripts\python.exe" (
  %PY% -m venv .venv
  if errorlevel 1 (
    echo Could not create the virtualenv. 1>&2
    exit /b 1
  )
)
".venv\Scripts\python.exe" -m pip install -q --disable-pip-version-check -r requirements.txt
if errorlevel 1 (
  echo Dependency install failed. Check your network connection and re-run. 1>&2
  exit /b 1
)

echo.
set "HAVEKEY="
if exist ".env" (
  findstr /r /c:"^ANTHROPIC_API_KEY=." ".env" >nul 2>&1
  if not errorlevel 1 set "HAVEKEY=1"
)
if defined HAVEKEY (
  echo ==^> .env already contains a key; leaving it alone. To replace it, delete python\.env and re-run.
) else (
  echo ==^> Anthropic API key - optional, only needed for the Claude judge example.
  echo     Paste the key your interviewer gave you, or press Enter to skip.
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$s = Read-Host -AsSecureString '    Key'; $k = ([System.Net.NetworkCredential]::new('', $s).Password -replace '\s','').Trim([char]34,[char]39); if ($k) { [IO.File]::WriteAllText((Join-Path (Get-Location).Path '.env'), 'ANTHROPIC_API_KEY=' + $k + [Environment]::NewLine); Write-Host '    Saved to python\.env (git-ignored).' } else { Write-Host '    Skipped. The judge example will be skipped too. You can re-run this script later.' }"
)

echo.
echo Setup complete. Run the tests with:  .\run-tests.cmd
endlocal
