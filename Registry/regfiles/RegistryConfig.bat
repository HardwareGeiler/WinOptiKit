@echo off
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Restarting as Administrator...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
title Registry File Selector
:start
echo.
echo Select an option to execute the corresponding registry file:
echo.
echo 1. Run Windows 11 Registry
echo 2. Add_Take_Ownership_context_menu
echo 3. Exit
echo.

set /p choice=Please enter your choice (1-3): 

set "currentDir=%~dp0"

if "%choice%"=="1" (
    echo.
    echo Executing Registry File 1...
    regedit /s "%currentDir%\Files\reg11.reg"
    goto end
) else if "%choice%"=="2" (
    echo.
    echo Executing Registry File 2...
    regedit /s "%currentDir%\Files\contextmenu.reg"
    goto end
) else if "%choice%"=="3" (
    echo.
    echo Exiting...
    goto end
) else (
    echo.
    echo Invalid input. Please try again.
    goto :start
)

:end
echo.
echo Done.
pause
exit
