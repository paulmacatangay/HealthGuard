# HealthGuard App Launcher (PowerShell)
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "HealthGuard App Launcher" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Change to the script directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

Write-Host "Current directory: $PWD" -ForegroundColor Gray
Write-Host ""

# Check if pubspec.yaml exists
if (-Not (Test-Path "pubspec.yaml")) {
    Write-Host "[ERROR] pubspec.yaml not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Expected location: $PWD\pubspec.yaml" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please make sure you're running this script from the sdg_app directory." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "[OK] Found pubspec.yaml" -ForegroundColor Green
Write-Host ""

# Check if Flutter is installed
try {
    $flutterVersion = flutter --version 2>&1 | Out-String
    if ($LASTEXITCODE -ne 0) {
        throw "Flutter not found"
    }
    Write-Host "[OK] Flutter is installed" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "[ERROR] Flutter is not installed or not in PATH!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Flutter and add it to your system PATH." -ForegroundColor Yellow
    Write-Host "Visit: https://flutter.dev/docs/get-started/install" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

# Get Flutter dependencies
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing dependencies..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
flutter pub get

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "[ERROR] Failed to install dependencies!" -ForegroundColor Red
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "[OK] Dependencies installed successfully" -ForegroundColor Green
Write-Host ""

# Run the app
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting HealthGuard App..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

flutter run

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "[ERROR] App failed to start!" -ForegroundColor Red
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Read-Host "`nPress Enter to exit"

