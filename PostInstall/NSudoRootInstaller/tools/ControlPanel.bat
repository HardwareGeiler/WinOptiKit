setlocal enabledelayedexpansion

call "%~dp0\..\files\Tools_Header.bat"

"%nsudoexe%" -U:T -P:E "control"
