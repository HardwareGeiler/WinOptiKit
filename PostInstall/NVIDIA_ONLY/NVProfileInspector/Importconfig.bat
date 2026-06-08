@echo off
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Restarting as Administrator...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: NVIDIA Inspector Profile
echo Applying NVIDIA Inspector Profile
if exist "C:\NvidiaProfileInspector" rd /s /q "C:\NvidiaProfileInspector" >nul 2>&1

curl -g -k -L -# -o "%temp%\nvidiaProfileInspector.zip" "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/latest/download/nvidiaProfileInspector.zip"
if not exist "%temp%\nvidiaProfileInspector.zip" (
    echo error: Failed to download nvidiaProfileInspector.
    pause
    exit /b 1
)

powershell -NoProfile -Command "Expand-Archive '%temp%\nvidiaProfileInspector.zip' -DestinationPath 'C:\NvidiaProfileInspector\'" >nul 2>&1
del /F /Q "%temp%\nvidiaProfileInspector.zip" >nul 2>&1

curl -g -k -L -# -o "C:\NvidiaProfileInspector\xilly_nv_profile.nip" "https://github.com/ancel1x/Ancels-Performance-Batch/raw/main/bin/ancel_nv_profile.nip"
if not exist "C:\NvidiaProfileInspector\xilly_nv_profile.nip" (
    echo error: Failed to download NVIDIA profile.
    pause
    exit /b 1
)

start "" /wait "C:\NvidiaProfileInspector\nvidiaProfileInspector.exe" "C:\NvidiaProfileInspector\xilly_nv_profile.nip"
timeout /t 3 /nobreak >nul 2>&1

echo Profile applied successfully.
pause