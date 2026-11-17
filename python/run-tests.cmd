@echo off
rem Run the test suite inside the virtualenv created by setup.cmd.
rem   run-tests.cmd             all tests
rem   run-tests.cmd -k smoke    extra arguments are passed to pytest
setlocal
cd /d "%~dp0"

if not exist ".venv\Scripts\python.exe" (
  echo No .venv found. Run:  .\setup.cmd 1>&2
  exit /b 1
)

".venv\Scripts\python.exe" -m pytest -rs %*
if errorlevel 1 (
  echo. 1>&2
  echo Tests failed. If you see 401 invalid x-api-key, the key is wrong or expired: 1>&2
  echo delete python\.env, re-run .\setup.cmd, and ask your interviewer for a new key if needed. 1>&2
  exit /b 1
)
endlocal
