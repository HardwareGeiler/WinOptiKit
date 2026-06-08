setlocal enabledelayedexpansion

call "%~dp0\..\files\Tools_Header.bat"

"%nsudoexe%" -U:T -P:E "C:\Windows\System32\rundll32.exe" C:\Windows\System32\shell32.dll,Options_RunDLL 0
