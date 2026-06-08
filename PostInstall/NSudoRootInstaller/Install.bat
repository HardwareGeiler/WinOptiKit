@echo off
cls
setlocal enabledelayedexpansion

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Restarting as Administrator...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

cd /D %~dp0
title Melody's NSudo Root Installer
echo Melody's NSudo Root Installer
echo.

cd /D %~dp0
IF NOT EXIST "files" (
	echo Error: Missing files directory
	echo Make sure everything has been extracted and that your AV is not messing with the files
	echo Exiting
	pause
	exit
)
cd files
IF NOT EXIST "NSudoLC.exe" (
	echo Error: Missing NSudoLC executable
	echo Make sure everything has been extracted and that your AV is not messing with the files
	echo Exiting
	pause
	exit
)
IF NOT EXIST "regload.reg" (
	echo Error: Missing regload registry file
	echo Make sure everything has been extracted and that your AV is not messing with the files
	echo Exiting
	pause
	exit
)
IF NOT EXIST "C:\Windows\system32\reg.exe" (
	echo Error: REG is missing from system32
	echo Exiting
	pause
	exit
)

echo This will install Run as TrustedInstaller option when right clicking specific files
echo Press a key if you want to proceed
echo Otherwise close the cmd prompt
pause

IF NOT EXIST "C:\sw\bin\NSudoLC.exe" (
	IF NOT EXIST "C:\sw" (
		mkdir "C:\sw"
	)
	IF NOT EXIST "C:\sw\bin" (
		mkdir "C:\sw\bin"
	)
	copy "NSudoLC.exe" "C:\sw\bin\NSudoLC.exe" /Y
	if %errorlevel% neq 0 (
		echo Error: Failed to copy NSudoLC.exe
		echo Exiting
		pause
		exit
	)
)

start "" /wait "NSudoLC.exe" -U:T -P:E "reg" import regload.reg
if %errorlevel% neq 0 (
	echo Warning: reg did not return errorlevel 0
	echo Some errors might have occurred
) else (
	echo REG ran successfully
)

echo Script finished
pause
