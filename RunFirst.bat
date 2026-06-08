@echo off
title WinOptiKit - RunFirst
color 0A

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Restarting as Administrator...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo ============================================
echo   WinOptiKit - RunFirst
echo ============================================
echo.

echo [1/2] Disabling UAC...
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f >nul 2>&1
if %errorlevel% equ 0 (
    echo       [OK] UAC disabled.
) else (
    echo       [FAIL] Could not disable UAC.
)

echo [2/2] Setting PowerShell Execution Policy to Unrestricted...
powershell.exe -Command "Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force" >nul 2>&1
if %errorlevel% equ 0 (
    echo       [OK] Execution Policy set.
) else (
    echo       [FAIL] Could not set Execution Policy.
)

echo.
echo   Done. A reboot is required for UAC changes to take effect.
echo.
pause >nul