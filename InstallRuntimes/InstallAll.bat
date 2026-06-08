@echo off
cls
setlocal enabledelayedexpansion

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Restarting as Administrator...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

reg add "HKCU\CONSOLE" /v "VirtualTerminalLevel" /t REG_DWORD /d "1" /f >nul 2>&1

for /F "delims=#" %%a in ('prompt #$E# ^& for %%a in ^(1^) do rem') do set "ESC=%%a"
set b=%ESC%[94m
set c=%ESC%[36m
set r=%ESC%[31m
set d=%ESC%[0m
set m=%ESC%[95m
set u=%ESC%[4m


:Menu
chcp 65001 >nul 2>&1
cls
echo                                         %c%=====================================
echo                                         %c%=       %b% Framework Installer %d%      %c% =  %d%
echo                                         %c%=====================================
echo                                         %c%=%d%  %b%%u%Select an option to proceed:%d%     %c%=%d%
echo                                         %c%=                                   =  %d%
echo                                         %c%=%d%  %b%1. Install .NET Desktop Runtimes %c%=%d%
echo                                         %c%=                                   =  %d%
echo                                         %c%=%d%  %b%2. Install Visual C++ Redist      %c%=%d%
echo                                         %c%=                                   =  %d%
echo                                         %c%=%d%  %b%3. Install DirectX               %c%=%d%
echo                                         %c%=                                   =  %d%
echo                                         %c%=%d%  %b%4. Install All                   %c%=%d%
echo                                         %c%=                                   =  %d%
echo                                         %c%=%d%  %b%5. Information %d%                  %c%=%d%
echo                                         %c%=                                   =  %d%
echo                                         %c%=%d%  %b%6. Exit %d%                         %c%=%d%
echo                                         %c%=                                   =  %d%
echo                                         %c%===================================== %d%
echo                                         %c%=  %b%   Created by HardwareGeiler   %c%  =
echo                                         %c%===================================== %d%
echo.
echo                                                %b%Enter your choice (1-6) %d%
set /p choice=
if "%choice%"=="1" call :InstallFrameworks & pause & goto Menu
if "%choice%"=="2" call :InstallVC & pause & goto Menu
if "%choice%"=="3" call :InstallDirectX & pause & goto Menu
if "%choice%"=="4" goto InstallAll
if "%choice%"=="5" goto Information
if "%choice%"=="6" goto Exit

echo Invalid choice. Try again!
pause
goto Menu

:InstallFrameworks
cls
    echo Installing .NET 5.0 Desktop Runtime (x86)...
    powershell -Command "Invoke-WebRequest 'https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/5.0.17/windowsdesktop-runtime-5.0.17-win-x86.exe' -OutFile '%temp%\windowsdesktop-runtime-5.0.17-win-x86.exe'"
    start /wait %temp%\windowsdesktop-runtime-5.0.17-win-x86.exe /quiet /norestart
    del /F /Q %temp%\windowsdesktop-runtime-5.0.17-win-x86.exe >nul 2>&1

    echo Installing .NET 5.0 Desktop Runtime (x64)...
    powershell -Command "Invoke-WebRequest 'https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/5.0.17/windowsdesktop-runtime-5.0.17-win-x64.exe' -OutFile '%temp%\windowsdesktop-runtime-5.0.17-win-x64.exe'"
    start /wait %temp%\windowsdesktop-runtime-5.0.17-win-x64.exe /quiet /norestart
    del /F /Q %temp%\windowsdesktop-runtime-5.0.17-win-x64.exe >nul 2>&1

    echo Installing .NET 6.0 Desktop Runtime (x86)...
    powershell -Command "Invoke-WebRequest 'https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/6.0.36/windowsdesktop-runtime-6.0.36-win-x86.exe' -OutFile '%temp%\windowsdesktop-runtime-6.0.36-win-x86.exe'"
    start /wait %temp%\windowsdesktop-runtime-6.0.36-win-x86.exe /quiet /norestart
    del /F /Q %temp%\windowsdesktop-runtime-6.0.36-win-x86.exe >nul 2>&1

    echo Installing .NET 6.0 Desktop Runtime (x64)...
    powershell -Command "Invoke-WebRequest 'https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/6.0.36/windowsdesktop-runtime-6.0.36-win-x64.exe' -OutFile '%temp%\windowsdesktop-runtime-6.0.36-win-x64.exe'"
    start /wait %temp%\windowsdesktop-runtime-6.0.36-win-x64.exe /quiet /norestart
    del /F /Q %temp%\windowsdesktop-runtime-6.0.36-win-x64.exe >nul 2>&1

    echo Installing .NET 7.0 Desktop Runtime (x86)...
    powershell -Command "Invoke-WebRequest 'https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/7.0.20/windowsdesktop-runtime-7.0.20-win-x86.exe' -OutFile '%temp%\windowsdesktop-runtime-7.0.20-win-x86.exe'"
    start /wait %temp%\windowsdesktop-runtime-7.0.20-win-x86.exe /quiet /norestart
    del /F /Q %temp%\windowsdesktop-runtime-7.0.20-win-x86.exe >nul 2>&1

    echo Installing .NET 7.0 Desktop Runtime (x64)...
    powershell -Command "Invoke-WebRequest 'https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/7.0.20/windowsdesktop-runtime-7.0.20-win-x64.exe' -OutFile '%temp%\windowsdesktop-runtime-7.0.20-win-x64.exe'"
    start /wait %temp%\windowsdesktop-runtime-7.0.20-win-x64.exe /quiet /norestart
    del /F /Q %temp%\windowsdesktop-runtime-7.0.20-win-x64.exe >nul 2>&1

    echo Installing .NET 8.0 Desktop Runtime (x86)...
    powershell -Command "Invoke-WebRequest 'https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/8.0.27/windowsdesktop-runtime-8.0.27-win-x86.exe' -OutFile '%temp%\windowsdesktop-runtime-8.0.27-win-x86.exe'"
    start /wait %temp%\windowsdesktop-runtime-8.0.27-win-x86.exe /quiet /norestart
    del /F /Q %temp%\windowsdesktop-runtime-8.0.27-win-x86.exe >nul 2>&1

    echo Installing .NET 8.0 Desktop Runtime (x64)...
    powershell -Command "Invoke-WebRequest 'https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/8.0.27/windowsdesktop-runtime-8.0.27-win-x64.exe' -OutFile '%temp%\windowsdesktop-runtime-8.0.27-win-x64.exe'"
    start /wait %temp%\windowsdesktop-runtime-8.0.27-win-x64.exe /quiet /norestart
    del /F /Q %temp%\windowsdesktop-runtime-8.0.27-win-x64.exe >nul 2>&1

    echo Installing .NET 9.0 Desktop Runtime (x86)...
    powershell -Command "Invoke-WebRequest 'https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/9.0.16/windowsdesktop-runtime-9.0.16-win-x86.exe' -OutFile '%temp%\windowsdesktop-runtime-9.0.16-win-x86.exe'"
    start /wait %temp%\windowsdesktop-runtime-9.0.16-win-x86.exe /quiet /norestart
    del /F /Q %temp%\windowsdesktop-runtime-9.0.16-win-x86.exe >nul 2>&1

    echo Installing .NET 9.0 Desktop Runtime (x64)...
    powershell -Command "Invoke-WebRequest 'https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/9.0.16/windowsdesktop-runtime-9.0.16-win-x64.exe' -OutFile '%temp%\windowsdesktop-runtime-9.0.16-win-x64.exe'"
    start /wait %temp%\windowsdesktop-runtime-9.0.16-win-x64.exe /quiet /norestart
    del /F /Q %temp%\windowsdesktop-runtime-9.0.16-win-x64.exe >nul 2>&1

    echo Installing .NET 10.0 Desktop Runtime (x86)...
    powershell -Command "Invoke-WebRequest 'https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/10.0.8/windowsdesktop-runtime-10.0.8-win-x86.exe' -OutFile '%temp%\windowsdesktop-runtime-10.0.8-win-x86.exe'"
    start /wait %temp%\windowsdesktop-runtime-10.0.8-win-x86.exe /quiet /norestart
    del /F /Q %temp%\windowsdesktop-runtime-10.0.8-win-x86.exe >nul 2>&1

    echo Installing .NET 10.0 Desktop Runtime (x64)...
    powershell -Command "Invoke-WebRequest 'https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/10.0.8/windowsdesktop-runtime-10.0.8-win-x64.exe' -OutFile '%temp%\windowsdesktop-runtime-10.0.8-win-x64.exe'"
    start /wait %temp%\windowsdesktop-runtime-10.0.8-win-x64.exe /quiet /norestart
    del /F /Q %temp%\windowsdesktop-runtime-10.0.8-win-x64.exe >nul 2>&1

exit /b

:InstallVC
cls
    echo Installing Visual C++ 2008 Redistributable (x86)...
    powershell -Command "Invoke-WebRequest 'https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe' -OutFile '%temp%\vc2008_redist.x86.exe'"
    start /wait %temp%\vc2008_redist.x86.exe /q
    del /F /Q %temp%\vc2008_redist.x86.exe >nul 2>&1

    echo Installing Visual C++ 2008 Redistributable (x64)...
    powershell -Command "Invoke-WebRequest 'https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe' -OutFile '%temp%\vc2008_redist.x64.exe'"
    start /wait %temp%\vc2008_redist.x64.exe /q
    del /F /Q %temp%\vc2008_redist.x64.exe >nul 2>&1

    echo Installing Visual C++ 2010 Redistributable (x86)...
    powershell -Command "Invoke-WebRequest 'https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe' -OutFile '%temp%\vc2010_redist.x86.exe'"
    start /wait %temp%\vc2010_redist.x86.exe /q /norestart
    del /F /Q %temp%\vc2010_redist.x86.exe >nul 2>&1

    echo Installing Visual C++ 2010 Redistributable (x64)...
    powershell -Command "Invoke-WebRequest 'https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe' -OutFile '%temp%\vc2010_redist.x64.exe'"
    start /wait %temp%\vc2010_redist.x64.exe /q /norestart
    del /F /Q %temp%\vc2010_redist.x64.exe >nul 2>&1

    echo Installing Visual C++ 2012 Redistributable (x86)...
    powershell -Command "Invoke-WebRequest 'https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe' -OutFile '%temp%\vc2012_redist.x86.exe'"
    start /wait %temp%\vc2012_redist.x86.exe /quiet /norestart
    del /F /Q %temp%\vc2012_redist.x86.exe >nul 2>&1

    echo Installing Visual C++ 2012 Redistributable (x64)...
    powershell -Command "Invoke-WebRequest 'https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe' -OutFile '%temp%\vc2012_redist.x64.exe'"
    start /wait %temp%\vc2012_redist.x64.exe /quiet /norestart
    del /F /Q %temp%\vc2012_redist.x64.exe >nul 2>&1

    echo Installing Visual C++ 2013 Redistributable (x86)...
    powershell -Command "Invoke-WebRequest 'https://aka.ms/highdpimfc2013x86enu' -OutFile '%temp%\vc2013_redist.x86.exe'"
    start /wait %temp%\vc2013_redist.x86.exe /quiet /norestart
    del /F /Q %temp%\vc2013_redist.x86.exe >nul 2>&1

    echo Installing Visual C++ 2013 Redistributable (x64)...
    powershell -Command "Invoke-WebRequest 'https://aka.ms/highdpimfc2013x64enu' -OutFile '%temp%\vc2013_redist.x64.exe'"
    start /wait %temp%\vc2013_redist.x64.exe /quiet /norestart
    del /F /Q %temp%\vc2013_redist.x64.exe >nul 2>&1

    echo Installing Visual C++ 2015-2022 Redistributable (x86)...
    powershell -Command "Invoke-WebRequest 'https://aka.ms/vs/17/release/vc_redist.x86.exe' -OutFile '%temp%\vc2015_2022_redist.x86.exe'"
    start /wait %temp%\vc2015_2022_redist.x86.exe /install /quiet /norestart
    del /F /Q %temp%\vc2015_2022_redist.x86.exe >nul 2>&1

    echo Installing Visual C++ 2015-2022 Redistributable (x64)...
    powershell -Command "Invoke-WebRequest 'https://aka.ms/vs/17/release/vc_redist.x64.exe' -OutFile '%temp%\vc2015_2022_redist.x64.exe'"
    start /wait %temp%\vc2015_2022_redist.x64.exe /install /quiet /norestart
    del /F /Q %temp%\vc2015_2022_redist.x64.exe >nul 2>&1

    echo Visual C++ Redistributables installed successfully.
exit /b

:InstallDirectX
cls
    echo Installing DirectX End-User Runtime...
    powershell -Command "Invoke-WebRequest 'https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe' -OutFile '%temp%\dxwebsetup.exe'"
    start /wait %temp%\dxwebsetup.exe /Q
    del /F /Q %temp%\dxwebsetup.exe >nul 2>&1
    echo DirectX installed successfully.
exit /b

:InstallAll
cls
echo Installing all components...
call :InstallFrameworks
call :InstallVC
call :InstallDirectX
echo.
echo All components installed successfully.
pause
goto Menu

:Information
cls
echo                                         %c%=====================================%d%
echo                                        %c% = %d%       %b% Information  Menu        %c% =%d%
echo                                         %c%=====================================%d%
echo                                         %c%=%d%  %u%%b%Select an option to learn more:%d%  %c%=%d%
echo                                         %c%=                                   =  %d%
echo                                         %c%=%d%%b%  1. About .NET Desktop Runtimes   %c%=%d%
echo                                         %c%=                                   =  %d%
echo                                         %c%=%d%%b%  2. About Visual C++ Redist       %c%=%d%
echo                                         %c%=                                   =  %d%
echo                                         %c%=%d%%b%  3. About DirectX                 %c%=%d%
echo                                         %c%=                                   =  %d%
echo                                         %c%=%d%%b%  4. Back to Main Menu             %c%=%d%
echo                                         %c%=                                   =  %d%
echo                                         %c%=====================================%d%
echo.
echo                                                 %b%Enter your choice (1-4)
set /p infochoice=

if "%infochoice%"=="1" goto InfoDotNet
if "%infochoice%"=="2" goto InfoVC
if "%infochoice%"=="3" goto InfoDirectX
if "%infochoice%"=="4" goto Menu

echo Invalid choice. Please run the script again.
pause
goto Information

:InfoDotNet
cls
echo .NET is a free, cross-platform, open-source developer platform by Microsoft.
echo The Desktop Runtime is required to run Windows desktop apps built with WPF or WinForms.
echo This installer includes legacy versions (5.0, 6.0, 7.0) and supported versions (8.0, 9.0, 10.0).
echo To learn more, visit:
echo https://dotnet.microsoft.com/en-us/download
pause
goto Information

:InfoVC
cls
echo Visual C++ Redistributable is a package of Microsoft C++ (MSVC) runtime libraries.
echo These libraries are required to run applications developed with Visual Studio.
echo This installer includes older packages (2008, 2010, 2012, 2013) and the latest (2015-2022).
echo To learn more, visit:
echo https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist
pause
goto Information

:InfoDirectX
cls
echo DirectX End-User Runtime installs legacy DirectX components (D3DX9, D3DX10, D3DX11, XAudio 2.7)
echo required by older games and applications. Modern DirectX 12 is included with Windows
echo and updated via Windows Update. To learn more, visit:
echo https://www.microsoft.com/en-us/download/details.aspx?id=35
pause
goto Information

:Exit
exit
