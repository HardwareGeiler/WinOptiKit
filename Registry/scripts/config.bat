@echo off
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Restarting as Administrator...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: Disable password expiration
net accounts /maxpwage:unlimited >nul 2>&1

:: Delete the EdgeUpdate folder if it exists
taskkill /F /IM EdgeUpdate.exe >nul 2>&1
if exist "C:\Program Files (x86)\Microsoft\EdgeUpdate" (
    rd /s /q "C:\Program Files (x86)\Microsoft\EdgeUpdate" >nul 2>&1
)

:: Delete all shortcuts with the name "edge.lnk"
for /f "delims=" %%a in ('where /r C:\ *edge.lnk* 2^>nul') do (
    if exist "%%a" (
        del /f /q "%%a" >nul 2>&1
    )
)

:: Disable GameDVR
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

:: Disable Dynamic Tick
bcdedit /set disabledynamictick yes >nul 2>&1

:: Filesystem optimizations
fsutil behavior set disable8dot3 1 >nul 2>&1
fsutil behavior set disablelastaccess 1 >nul 2>&1

:: Platform clock and tick settings
bcdedit /set useplatformclock No >nul 2>&1
bcdedit /set useplatformtick No >nul 2>&1

:: Wait for user input
pause
