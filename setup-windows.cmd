@echo off
cd /d "%~dp0"
if not exist frontend\.env.local copy frontend\.env.example frontend\.env.local
if not exist backend\.env copy backend\.env.example backend\.env
where node >nul 2>nul
if errorlevel 1 goto missingnode
py -3.13 -m venv backend\.venv
if errorlevel 1 goto missingpython
backend\.venv\Scripts\python -m pip install -r backend\requirements.txt
if errorlevel 1 goto failed
cd frontend
call npm ci --legacy-peer-deps
if errorlevel 1 goto failed
echo Setup completed. Edit frontend\.env.local and backend\.env before starting.
pause
exit /b 0
:missingnode
echo Install Node.js 22 LTS or newer first.
goto failed
:missingpython
echo Install Python 3.13 and the Windows Python launcher first.
:failed
echo Setup did not finish. Read the error above.
pause
exit /b 1
