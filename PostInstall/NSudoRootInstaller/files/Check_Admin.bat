echo Checking Admin privileges...

IF EXIST "C:\Windows\system32\adminrightstest" (
	rmdir C:\Windows\system32\adminrightstest > nul
)
mkdir C:\Windows\system32\adminrightstest > nul
if %errorlevel% neq 0 (
	echo Please run the script as Admin
	echo Exiting
	exit
)
rmdir C:\Windows\system32\adminrightstest > nul
