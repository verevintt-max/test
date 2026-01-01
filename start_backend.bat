@echo off
cd /d "%~dp0\backend"

echo ========================================
echo Starting Backend Server
echo ========================================
echo.

echo Checking Python...
REM Try py first (Windows Python Launcher)
py --version >nul 2>&1
if %ERRORLEVEL% equ 0 (
    set PYTHON_CMD=py
    goto :python_found
)

REM Try python
python --version >nul 2>&1
if %ERRORLEVEL% equ 0 (
    set PYTHON_CMD=python
    goto :python_found
)

REM Try python3
python3 --version >nul 2>&1
if %ERRORLEVEL% equ 0 (
    set PYTHON_CMD=python3
    goto :python_found
)

echo ERROR: Python not found!
echo.
echo Install Python from https://python.org
echo Make sure to check "Add Python to PATH" during installation
echo.
pause
exit /b 1

:python_found
echo Using: %PYTHON_CMD%
%PYTHON_CMD% --version
echo.

echo Installing dependencies...
%PYTHON_CMD% -m pip install -r requirements.txt
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR installing dependencies!
    echo.
    echo Try running manually:
    echo   cd backend
    echo   %PYTHON_CMD% -m pip install -r requirements.txt
    echo.
    pause
    exit /b 1
)

echo.
echo Initializing database...
%PYTHON_CMD% init_db.py

echo.
echo Starting server...
echo.
echo Server will be available at http://localhost:8000
echo API docs: http://localhost:8000/docs
echo.
echo Press Ctrl+C to stop the server
echo.
echo ========================================
echo.

%PYTHON_CMD% run.py

echo.
echo Server stopped.
pause
