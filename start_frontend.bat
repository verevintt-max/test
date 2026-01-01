@echo off
echo ========================================
echo Starting Frontend Server
echo ========================================
echo.

cd /d "%~dp0"

if not exist "frontend" (
    echo ERROR: Frontend folder not found!
    pause
    exit /b 1
)

cd frontend

echo Checking Node.js...
where node >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR: Node.js not found!
    echo Install Node.js from https://nodejs.org
    echo.
    pause
    exit /b 1
)

node --version
echo Node.js found
echo.

echo Installing dependencies...
call npm install
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR installing dependencies!
    pause
    exit /b 1
)

echo.
echo Starting dev server...
echo.
echo Frontend will be available at http://localhost:3000
echo.
echo Press Ctrl+C to stop
echo.

call npm run dev

pause
