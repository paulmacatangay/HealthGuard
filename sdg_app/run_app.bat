@echo off
REM Change to the directory where this batch file is located
cd /d "%~dp0"

REM Display current directory
echo ========================================
echo HealthGuard App Launcher
echo ========================================
echo.
echo Current directory: %CD%
echo.

REM Check if pubspec.yaml exists
if not exist "pubspec.yaml" (
    echo [ERROR] pubspec.yaml not found!
    echo.
    echo Expected location: %CD%\pubspec.yaml
    echo.
    echo Please make sure you're running this script from the sdg_app directory.
    echo.
    pause
    exit /b 1
)

echo [OK] Found pubspec.yaml
echo.

REM Check if Flutter is installed
where flutter >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Flutter is not installed or not in PATH!
    echo.
    echo Please install Flutter and add it to your system PATH.
    echo Visit: https://flutter.dev/docs/get-started/install
    echo.
    pause
    exit /b 1
)

echo [OK] Flutter is installed
echo.

REM Get Flutter dependencies
echo ========================================
echo Installing dependencies...
echo ========================================
flutter pub get
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Failed to install dependencies!
    echo.
    pause
    exit /b 1
)

echo.
echo [OK] Dependencies installed successfully
echo.

REM Run the app
echo ========================================
echo Starting HealthGuard App...
echo ========================================
echo.
flutter run

REM If flutter run exits, pause to see any errors
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] App failed to start!
    echo.
    pause
    exit /b 1
)

pause


