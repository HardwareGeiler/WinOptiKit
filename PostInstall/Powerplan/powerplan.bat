@echo off
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Restarting as Administrator...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:PowerPlan
cls
echo Applying Ancels Power Plan
:: Import Ancels Power Plan
curl -g -k -L -# -o "C:\AncelsPowerPlan.pow" "https://github.com/HardwareGeiler/AncelsPowerPlan/releases/latest/download/Ancels_Power_Plan.pow"
if not exist "C:\AncelsPowerPlan.pow" (
    echo [FAIL] Download failed.
    pause
    exit /b
)

powercfg -import "C:\AncelsPowerPlan.pow" 11111111-1111-1111-1111-111111111112 >nul 2>&1
powercfg -setactive 11111111-1111-1111-1111-111111111112 >nul 2>&1

powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 d4e98f31-5ffe-4ce1-be31-1b38b384c009 0 >nul 2>&1
powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318584 100 >nul 2>&1
powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 4d2b0152-7d5c-498b-88e2-34345392a2c5 5000 >nul 2>&1
powercfg /setactive scheme_current >nul 2>&1

del /F /Q "C:\AncelsPowerPlan.pow" >nul 2>&1
pause