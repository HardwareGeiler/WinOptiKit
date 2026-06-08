setlocal enabledelayedexpansion

call "%~dp0\..\files\Tools_Header.bat"

"%nsudoexe%" -U:T -P:E "C:\Windows\system32\mmc.exe" C:\Windows\system32\devmgmt.msc
