@echo off
cls

call "%~dp0\Check_Admin.bat"

set nsudoexe=

IF EXIST "C:\sw\bin\NSudoLC.exe" (
	set "nsudoexe=C:\sw\bin\NSudoLC.exe"
) else (
	IF EXIST "%~dp0\NSudoLC.exe" (
		set "nsudoexe=%~dp0\..\files\NSudoLC.exe"
	) else (
		set nsudoexe=0
	)
)

if "%nsudoexe%" equ "0" (
	echo Error: Failed to find NSudo
	echo Exiting
	pause
	exit 1
)
