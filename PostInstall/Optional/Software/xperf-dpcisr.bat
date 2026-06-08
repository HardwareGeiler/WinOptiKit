@echo off
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Restarting as Administrator...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

REM Check if xperf.exe exists in the path
where xperf.exe >nul 2>&1
if %errorlevel% neq 0 (
    echo error: xperf not found in path. Installing it now >&2
    powershell -Command "Invoke-WebRequest 'https://go.microsoft.com/fwlink/?linkid=2243390' -OutFile 'C:\adksetup.exe'"
    if not exist "C:\adksetup.exe" (
        echo error: Failed to download adksetup.exe.
        pause
        exit /b 1
    )
    start "" /wait C:\adksetup.exe /quiet /features OptionId.WindowsPerformanceToolkit
    del /F /Q C:\adksetup.exe >nul 2>&1
    echo info: Xperf installed successfully.
    echo info: Please run the script again to continue.
    pause
    exit /b 0
)

REM Set recording delay and duration
set "record_delay=3"
set "record_duration=5"

echo info: Starting in %record_delay%s
timeout /t %record_delay% > nul

echo info: Recording for %record_duration%s
xperf -on base+interrupt+dpc >nul 2>&1
timeout /t %record_duration% > nul

xperf -stop > nul
xperf -quiet -i "C:\kernel.etl" -o "C:\report.txt" -a dpcisr >nul 2>&1
echo info: Report saved in C:\

exit /b 0
