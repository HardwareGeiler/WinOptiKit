@echo off
title Network Optimizations
cls

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Restarting as Administrator...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:NetworkTweaks
cls

:: Reset Internet
echo Resetting Internet
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
ipconfig /flushdns >nul 2>&1
netsh int ip reset >nul 2>&1
netsh int ipv4 reset >nul 2>&1
netsh int ipv6 reset >nul 2>&1
netsh int tcp reset >nul 2>&1
netsh winsock reset >nul 2>&1
netsh advfirewall reset >nul 2>&1
netsh branchcache reset >nul 2>&1
netsh http flush logbuffer >nul 2>&1
timeout /t 3 /nobreak >nul 2>&1

:: Disable Network Throttling
echo Disabling Network Throttling
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Disable ECN
echo Disabling Explicit Congestion Notification
netsh int tcp set global ecncapability=disabled >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Disable RSC
echo Disabling Receive Side Coalescing
netsh int tcp set global rsc=disabled >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Enable RSS
echo Enabling Receive Side Scaling
netsh int tcp set global rss=enabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Ndis\Parameters" /v "RssBaseCpu" /t REG_DWORD /d "1" /f >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Disable TCP Timestamps
echo Disabling TCP Timestamps
netsh int tcp set global timestamps=disabled >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Set Initial RTO to 2ms
echo Setting Initial Retransmission Timer
netsh int tcp set global initialRto=2000 >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Set MTU Size to 1500
echo Setting MTU Size
for /f "tokens=1,*" %%a in ('netsh interface show interface ^| findstr /i "Connected"') do (
    netsh interface ipv4 set subinterface "%%b" mtu=1500 store=persistent >nul 2>&1
)
timeout /t 1 /nobreak >nul 2>&1

:: Disable NonSackRTTresiliency
echo Disabling Non Sack RTT Resiliency
netsh int tcp set global nonsackrttresiliency=disabled >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Set Max Syn Retransmissions to 2
echo Setting Max Syn Retransmissions
netsh int tcp set global maxsynretransmissions=2 >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Disable MPP
echo Disabling Memory Pressure Protection
netsh int tcp set security mpp=disabled >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Disable Security Profiles
echo Disabling Security Profiles
netsh int tcp set security profiles=disabled >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Disable Heuristics
echo Disabling Windows Scaling Heuristics
netsh int tcp set heuristics disabled >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Increase ARP Cache Size to 4096
echo Increasing ARP Cache Size
netsh int ip set global neighborcachelimit=4096 >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Enable CTCP
echo Enabling CTCP
netsh int tcp set supplemental Internet congestionprovider=ctcp >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Disable IPv6
echo Disabling IPv6
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d "255" /f >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Disable ISATAP
echo Disabling ISATAP
netsh int isatap set state disabled >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Disable Teredo
echo Disabling Teredo
netsh int teredo set state disabled >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Set TTL to 64
echo Configuring Time to Live
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d "64" /f >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Enable TCP Window Scaling
echo Enabling TCP Window Scaling
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d "1" /f >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Set TcpMaxDupAcks
echo Setting TcpMaxDupAcks to 2
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d "2" /f >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Disable SackOpts
echo Disabling TCP Selective ACKs
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d "0" /f >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Increase Maximum Port Number
echo Increasing Maximum Port Number
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d "65534" /f >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Decrease Time to Wait in "TIME_WAIT" State
echo Decreasing Timed Wait Delay
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d "30" /f >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Set Network Priorities
echo Setting Network Priorities
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "HostsPriority" /t REG_DWORD /d "5" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "DnsPriority" /t REG_DWORD /d "6" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "NetbtPriority" /t REG_DWORD /d "7" /f >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Adjust Sock Address Size
echo Configuring Sock Address Size
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MinSockAddrLength" /t REG_DWORD /d "16" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MaxSockAddrLength" /t REG_DWORD /d "16" /f >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

:: Disable Nagle's Algorithm
echo Disabling Nagle's Algorithm
for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul') do (
    reg add "%%i" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "%%i" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >nul 2>&1
)
timeout /t 1 /nobreak >nul 2>&1
