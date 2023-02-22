:: TüftelTyp ®2023
:: github.com/TueftelTyp
:: MIT License
@echo off
title Simple Windows Toolbox
mode 70,30
color 0A
:START
set VerNu=1.2.5.0
cls
echo ################################################################## 
echo #                 - Simple Windows Toolbox -                     #
echo #                           %VerNu%                              #
echo #                          Main Menu                             #
echo ##################################################################
echo # Make sure that the application is running as an administrator. #
echo ##################################################################
echo.
echo Enter the number to start your desired method.
echo.
echo 1  -- Windows Testmode
echo 2  -- Integrity Checks
echo 3  -- System File Check (sfc)
echo 4  -- Repair Windows image (dism)
echo 5  -- Network Tools  
echo 6  -- Release/Renew DHCP Lease 
echo 7  -- File Cleaner 
echo 8  -- Reseted Settings Fix 
echo.
echo 9  -- Next Page
echo    ~~
echo 0  -- Exit 
echo.
echo i  -- Info
echo R  -- Reboot
echo.
set /P varST="input: "

IF /i "%varST%"=="1" goto TESTMODE
IF /i "%varST%"=="2" goto INTEGRITY
IF /i "%varST%"=="3" goto SFC
IF /i "%varST%"=="4" goto DISM
IF /i "%varST%"=="5" goto NETTOOLS
IF /i "%varST%"=="6" goto DHCPLEASE
IF /i "%varST%"=="7" goto TEMPCLEAN
IF /i "%varST%"=="8" goto RSTSETFIX
IF /i "%varST%"=="9" goto PAGE2
IF /i "%varST%"=="0" goto EXIT
IF    "%varST%"=="R" goto REBOOT
IF /i "%varST%"=="i" goto ABOUT
goto FAIL
:TESTMODE
cls
echo ################################################################## 
echo #                 - Simple Windows Toolbox -                     #
echo #                       WINDOWS TESTMODE                         #
echo ##################################################################
echo.
echo 1 -- Enable Testmode
echo 2 -- Disable Testmode 
echo ~
echo 0 -- Back
echo.
set /P varTM="input: "
IF /i "%varTM%"=="1" goto ACTIVATETEST
IF /i "%varTM%"=="2" goto DEACTIVATETEST
IF /i "%varTM%"=="0" goto START
goto FAIL
:ACTIVATETEST
BCDEDIT –Set LoadOptions EENABLE_INTEGRITY_CHECKS >NUL
BCDEDIT –Set TESTSIGNING ON >NUL
cls
echo ################################################################## 
echo #                 - Simple Windows Toolbox -                     #
echo #                 WINDOWS TESTMODE - ACTIVE                      #
echo ##################################################################
echo #           ! installing Unsigned Drivers enabled !              #
echo.
goto REBOOTCHECK
:DEACTIVATETEST
BCDEDIT –Set LoadOptions DDISABLE_INTEGRITY_CHECKS >NUL
BCDEDIT –Set TESTSIGNING OFF >NUL
cls
echo ################################################################## 
echo #                 - Simple Windows Toolbox -                     #
echo #                 WINDOWS TESTMODE - INACTIVE                    #
echo ##################################################################
echo #           ! installing Unsigned Drivers disabled !             #
echo.
goto REBOOTCHECK
:INTEGRITY
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                   WINDOWS INTEGRITY CHECKS                     #
echo ##################################################################
echo.
echo 1 -- Enable Integrity Checks
echo 2 -- Disable Integrity Checks 
echo ~
echo 0 -- Back
echo.
set /P varIC="input: "
IF /i "%varIC%"=="1" goto ACTINTEGR
IF /i "%varIC%"=="2" goto DEACTINTEGR
IF /i "%varIC%"=="0" goto START
goto FAIL
:ACTINTEGR
bcdedit /set nointegritychecks on >NUL
cls
echo ################################################################## 
echo #                 - Simple Windows Toolbox -                     #
echo #              WINDOWS INTEGRITY CHECKS - ACTIVE                 #
echo ##################################################################
echo #                ! Integrity Checks enabled !                    #
echo.
goto REBOOTCHECK
:DEACTINTEGR
bcdedit /set nointegritychecks off >NUL
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #              WINDOWS INTEGRITY CHECKS - INACTIVE               #
echo ##################################################################
echo #                ! Integrity Checks disabled !                   #
echo.
goto REBOOTCHECK
:SFC
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  WINDOWS SYSTEM FILE CHECK                     #
echo ##################################################################
echo.
echo 1 -- Scan all
echo 2 -- Verify all
echo 3 -- Scan specific file
echo 4 -- Scan specific file (advanced options)
echo 5 -- Verify specific file
echo 6 -- Take ownership of currupted system file
echo 7 -- Replace the corrupted system file with a known good copy
echo ~
echo 0 -- Back
echo.
set /P varSFC="input: "
IF /i "%varSFC%"=="1" goto SCANNOW
IF /i "%varSFC%"=="2" goto VERIFYONLY
IF /i "%varSFC%"=="3" goto SCANSPEC
IF /i "%varSFC%"=="4" goto SCANSPECADV
IF /i "%varSFC%"=="5" goto VERIFYSPEC
IF /i "%varSFC%"=="5" goto OWNCURFILE
IF /i "%varSFC%"=="6" goto REPCURFILE
IF /i "%varSFC%"=="0" goto START
goto FAIL
:SCANNOW
cls
echo ################################################################## 
echo #                       SYSTEM FILE SCAN                         #
echo ##################################################################
echo.
sfc/scannow 
pause
goto SFC
:VERIFYONLY
cls
echo ################################################################## 
echo #                      SYSTEM FILE VERIFY                        #
echo ##################################################################
echo.
sfc/verifyonly
pause
goto SFC
:SCANSPEC
cls
echo ################################################################## 
echo #                     SPECIFIC FILE SCAN                         #
echo ##################################################################
echo.
set /P SPECPATH="exact file Path: "
sfc /scanfile=%SPECPATH%
pause
goto SFC
:SCANSPECADV
cls
echo ################################################################## 
echo #                 SPECIFIC FILE SCAN - ADVANCED                  #
echo ##################################################################
echo.
echo Exact path and file name:
set /P SPECPATH="Path: "
echo.
echo Offline boot directory location for offline repairs:
set /P OFBODI="Path: "
echo.
echo Location of the offline home directory for offline repairs:
set /P OFWIDI="Path: "
echo.
echo Location of the log file for offline repairs:
set /P OFLOFI="Path: "
echo.
sfc /scanfile=%SPECPATH% /offbootdir=%OFBODI% /offwindir=%OFWIDI% /offlogdir=%OFLOFI%
pause
goto SFC
:VERIFYSPEC
cls
echo ################################################################## 
echo #                    SPECIFIC FILE VERIFY                        #
echo ##################################################################
echo.
set /P SPECPATH="exact file Path: "
sfc /verifyfile=%SPECPATH%
pause
goto SFC
:OWNCURFILE
cls
echo ################################################################## 
echo #   TAKE ADMINISTRATIVE OWNERSHIP OF A CURRUPTED SYSTEM FILE     #
echo ##################################################################
echo.
set /P CURFIPATH="Path & file name: "
takeown /f %CURFIPATH%
pause
echo.
echo Grant administrators full access to the corrupted system file?
set /P varGRA="<y/n> "
IF /i "%varGRA%"=="y" goto varGRAtrue
goto SFC
:varGRAtrue
icacls %CURFIPATH% /GRANT ADMINISTRATORS:F
pause
goto SFC
:REPCURFILE
cls
echo ################################################################## 
echo #                  REPLACE CORRUPTED SYSTEM FILE                 #
echo ##################################################################
echo.
echo Path and file name of the corrupted file: 
set /P CURFIPATH="Path & file name: "
echo.
echo Path and file name of the known good copy: 
set /P GOFIPATH="Path & file name: "
copy %GORFIPATH% %CURFIPATH%
pause

:DISM
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                     WINDOWS IMAGE REPAIR                       #
echo ##################################################################
echo.
echo 1 -- Scan Windows image for corruption
echo 2 -- Fix Windows image 
echo ~
echo 0 -- Back
echo.
set /P varDISM="input: "
IF /i "%varDISM%"=="1" goto SCANIMG
IF /i "%varDISM%"=="2" goto FIXIMG
IF /i "%varDISM%"=="0" goto START
goto FAIL
:SCANIMG
cls
echo ################################################################## 
echo #                       SYSTEM FILE SCAN                         #
echo ##################################################################
echo.
DISM /Online /Cleanup-Image /CheckHealth
pause
goto DISM
:FIXIMG
cls
echo ################################################################## 
echo #                       SYSTEM FILE SCAN                         #
echo ##################################################################
echo.
DISM /Online /Cleanup-Image /ScanHealth
pause
goto DISM

:NETTOOLS
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                         NETWORK TOOLS                          #
echo ##################################################################
echo.
echo 1 -- Ping
echo 2 -- Network Scan (arp)
echo 3 -- Network Adapter Configuration (ipconfig)
echo 4 -- Show connections,ports,statistics,routing table,.. (netstat)
echo 5 -- Determine domain name of IP address or vice versa (nslookup)
echo 6 -- Adress tracing (tracert)
echo ~
echo 0  -- Main Menu
echo.
set /P varST2="input: "
IF /i "%varST2%"=="1" goto PING
IF /i "%varST2%"=="2" goto ARP
IF /i "%varST2%"=="3" goto IPCONF
IF /i "%varST2%"=="4" goto NETSTAT
IF /i "%varST2%"=="5" goto NSLOOK
IF /i "%varST2%"=="6" goto TRACE
IF /i "%varST2%"=="0" goto START
goto FAIL
:PING
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                            PING                                #
echo ##################################################################
echo.
echo Which adress do you want to ping? [0 = Back]
set /P varPING="IP / URL: " 
IF /i "%varPING%"=="0" goto NETTOOLS
ping %varPING%
pause
goto NETTOOLS
:ARP
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                             ARP                                #
echo ##################################################################
echo.
echo 1 -- Displaya current ARP entries by querying the log data (-a)
echo 2 -- Show current ARP entries in verbose mode. (-v)
echo 3 -- Edit Host-Entries
echo ~
echo 0 -- Back
echo.
set /P varArOp="Input: " 
IF /i "%varArOp%"=="1" set ArOp=-a
IF /i "%varArOp%"=="2" set ArOp=-v
IF /i "%varArOp%"=="3" goto ARPEDIT
IF /i "%varArOp%"=="0" goto NETTOOLS
arp %ArOp%
pause
goto NETTOOLS
:ARPEDIT
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                      ARP - EDIT ENTRIES                        #
echo ##################################################################
echo.
echo 1 -- Add Host-Entry (-s)
echo 2 -- Delete Host-Entry (-d)
echo ~
echo 0 -- Back
set /P ArHeC="Input: "
IF /i "%ArHeC%"=="1" set ArHeT=#                      ARP - ADD ENTRIES                         # 
IF /i "%ArHeC%"=="2" set ArHeT=#                     ARP - DELETE ENTRIES                       #
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo %ArHeT%
echo ##################################################################
echo.
IF /i "%ArHeC%"=="1" set ArHe=-s & echo INFO: The physical address is specified by 6 hexadecimal bytes
IF /i "%ArHeC%"=="1" echo separated by hyphens.    The entry is permanent. 
IF /i "%ArHeC%"=="2" set ArHe=-d & echo INFO: Deletes the by Inet-Adr. specified host entry. 
IF /i "%ArHeC%"=="2" echo Addr. can be provided with the "*"-wildcard to delete all hosts.
IF /i "%ArHeC%"=="0" goto NETTOOLS
echo.
echo Enter the Host-Entry want to add/remove. [0 = Back]
echo.
set /P ArHe="Input: "
IF /i "%ArHe%"=="0" goto ARP
arp %ArEOp% %ArHe%
pause
goto ARP
:IPCONF
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                          IP CONFIG                             #
echo ##################################################################
echo.
echo 1 -- Show all Config-Informations(all)
echo 2 -- Renew IPv4 Adress (renew)
echo ~
echo 0 -- Back
echo.
set /P varIPCO="Input: " 
IF /i "%varIPCO%"=="1" set ipCoOpt=/all
IF /i "%varIPCO%"=="2" set ipCoOpt=/renew
IF /i "%varIPCO%"=="0" goto NETTOOLS
ipconfig %ipCoOpt%
pause
goto NETTOOLS
:NETSTAT
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                           NETSTAT                              #
echo ##################################################################
echo.
echo Enter the number to start your desired method.
echo.
echo 1 -- Show all active Connections (-a -q)
echo 2 -- Show Routing-Table (-r)
echo 3 -- Show detailed statistics of TCP/IP data (-s)
echo 4 -- Show the current discharge status (-t)
echo ~
echo 0  -- Back
echo.
set /P varNTST="Input: "
IF /i "%varNTST%"=="1" set NtSt=-a -q
IF /i "%varNTST%"=="2" set NtSt=-r
IF /i "%varNTST%"=="3" set NtSt=-s
IF /i "%varNTST%"=="3" set NtSt=-t 
IF /i "%varNTST%"=="0" goto NETTOOLS
netstat %NtSt%
pause
goto NETTOOLS
:NSLOOK
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                          NSLOOKUP                              #
echo ##################################################################
echo.
echo.
echo Which address do you want to determine? [0 = Back]
set /P varNsLu="IP / URL / Domainname: " 
IF /i "%varNsLu%"=="0" goto NETTOOLS
nslookup %varNsLu%
pause
goto NETTOOLS
:TRACE
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                            TRACE                               #
echo ##################################################################
echo.
echo Which address do you want to trace? [0 = Back]
set /P varTRACE="IP / URL: " 
IF /i "%varTRACE%"=="0" goto NETTOOLS
tracert %varTRACE%
pause
goto NETTOOLS


:RSTSETFIX
cls
echo ################################################################## 
echo #                 - Simple Windows Toolbox -                     #
echo #                WINDOWS RESETED SETTINGS FIX                    #
echo ##################################################################
echo #                ! REPAIR REQUIERES A REBOOT !                   #
echo.
echo. 
set /P varRST="Do you want to restart now? <y/n>: "
IF /i "%varRST%"=="y" goto RST
goto START
:RST
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                WINDOWS RESETED SETTINGS FIX                    #
echo ##################################################################
echo #        ! ITS RECOMMENDED TO CLOSE ALL OPEN PROGRAMS !          #
timeout /t 300
echo.
set /P varRBC="Reboot now? <y/n> "
IF /i "%varRBC%"=="y" goto RESREBOOT
goto START
:RESREBOOT
shutdown /g /t 0 /c "WinFixToolbar" >NUL
exit
:DHCPLEASE
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                   DHCP LEASE RELEASE/RENEW                     #
echo ##################################################################
echo.
echo 1 -- Release DHCP Lease 
echo 2 -- Renew   DHCP Lease
echo ~
echo 0 -- Back
echo.
set /P varDHCP="input: "
IF /i "%varDHCP%"=="1" goto DHCPRELEASE
IF /i "%varDHCP%"=="2" goto DHCPRENEW
IF /i "%varDHCP%"=="0" goto START
goto FAIL
:DHCPRELEASE
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                     DHCP LEASE RELEASE                         #
echo ##################################################################
call LOADLOOP
ipconfig /release >nul
call JOBDONE
goto DHCPLEASE
:DHCPRENEW
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                       DHCP LEASE RENEW                         #
echo ##################################################################
call LOADLOOP
ipconfig /renew >NUL
call JOBDONE
goto DHCPLEASE
:TEMPCLEAN
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                    TEMPORARY FILE CLEANER                      #
echo ##################################################################
echo.
echo 1  -- Clean Manager
echo 2  -- Clean Users Temporary Files
echo 3  -- Clean Windows Temporary Files
echo 4  -- Clean RecycleBin
echo 5  -- Clear DNS Cache
echo 6  -- Clear Windows-Store Cache
echo 7  -- Clean Prefetch Files
echo 8  -- Delete Windows Update Cache
echo 9  -- Delete Icon and Thumbnail Cache
echo 10 -- Clear MS-Edge Cache
echo ~
echo 0 -- Back
echo.
set /P varTFC="input: "
IF /i "%varTFC%"=="1" goto CLMGR
IF /i "%varTFC%"=="2" goto USER
IF /i "%varTFC%"=="3" goto WINDOWS
IF /i "%varTFC%"=="4" goto RECBIN
IF /i "%varTFC%"=="5" goto CLDNS
IF /i "%varTFC%"=="6" goto CLWSC
IF /i "%varTFC%"=="7" goto CLPRE
IF /i "%varTFC%"=="8" goto DELWINUC
IF /i "%varTFC%"=="9" goto DELICTHU
IF /i "%varTFC%"=="10" goto EDGCC
IF /i "%varTFC%"=="0" goto START
goto FAIL
:CLMGR
cls 
cleanmgr
goto TEMPCLEAN
:USER
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                    TEMPORARY FILE CLEANER                      #
echo ##################################################################
echo #                ! Clean Users Temporary Files !                 #
echo.
call :getFoldersize "%Temp%"
echo.
echo Do you really want to delete all files?
set /P var2=" (y/n) > "
IF /i "%var2%"=="y" goto USERCLEAN
goto TEMPCLEAN
:USERCLEAN
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                WINDOWS TEMPORARY FILE CLEANER                  #
echo ##################################################################
echo #        ! ITS RECOMMENDED TO CLOSE ALL OPEN PROGRAMS !          #
echo.
timeout /t 300
cls
echo ################################################################## 
echo #                   ! CLEANING IN PROCESS !                      #
echo ##################################################################
cd %homepath%\AppData\Local\temp\ & del *.* /q /s /f  > nul
call :LOADLOOP
cls
echo ################################################################## 
echo #                     ! FILES CLEANED UP !                       #
echo ##################################################################
echo.
call :getFoldersize "%Temp%"
echo.
pause
goto TEMPCLEAN
:WINDOWS
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                    TEMPORARY FILE CLEANER                      #
echo ##################################################################
echo #              ! Clean Windows Temporary Files !                 #
echo.
call :getFoldersize "%systemdrive%\Windows\Temp"
echo.
echo Do you really want to delete all files? (y/n)
set /P var2=" (y/n) > "
IF /i "%var2%"=="y" goto WINDOWSCLEAN
goto TEMPCLEAN
:WINDOWSCLEAN
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                WINDOWS TEMPORARY FILE CLEANER                  #
echo ##################################################################
echo #        ! ITS RECOMMENDED TO CLOSE ALL OPEN PROGRAMS !          #
echo.
timeout /t 300
cls
echo ################################################################## 
echo #                   ! CLEANING IN PROCESS !                      #
echo ##################################################################
cd %systemdrive%\Windows\temp\ & del *.* /q /s /f  > nul
call :LOADLOOP
cls
echo ################################################################## 
echo #                     ! FILES CLEANED UP !                       #
echo ##################################################################
echo.
call :getFoldersize "%systemdrive%\Windows\Temp"
echo.
pause
goto TEMPCLEAN
:RECBIN
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                     RECYCLE BIN CLEANER                        #
echo ##################################################################
echo.
call :getFoldersize "%systemdrive%\$Recycle.Bin"
echo.
echo Do you really want to delete all files?
set /P varRB=" (y/n) > "
IF /i "%varRB%"=="y" goto RECBINCLEAN
goto TEMPCLEAN
:RECBINCLEAN
cls
call :LOADLOOP
start /b /wait powershell.exe -command "$Shell = New-Object -ComObject Shell.Application;$RecycleBin = $Shell.Namespace(0xA);$RecycleBin.Items() | foreach{Remove-Item $_.Path -Recurse -Confirm:$false}"
cls
echo ################################################################## 
echo #                  ! RECYLCE BIN CLEANED UP !                    #
echo ##################################################################
echo.
call :getFoldersize "%systemdrive%\$Recycle.Bin"
echo.
pause
goto TEMPCLEAN
:CLDNS
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                       CLEAR DNS CACHE                          #
echo ##################################################################
echo.
echo Do you want to flush your dns cache?
set /P varDNS=" (y/n) > "
IF /i "%varDNS%"=="y" goto DNSFLSH
goto TEMPCLEAN
:DNSFLSH
ipconfig/flushDNS > nul
call :LOADLOOP
cls
echo ################################################################## 
echo #              ! DNS RESOLVER CACHE CLEANED UP !                 #
echo ##################################################################
echo.
pause
goto TEMPCLEAN
:CLWSC
WSReset > nul
cls
echo ################################################################## 
echo #             ! WINDOWS STORE CACHE CLEANED UP !                 #
echo ##################################################################
echo.
pause
goto TEMPCLEAN
:CLPRE
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                    PREFETCH FILE CLEANER                       #
echo ##################################################################
echo.
call :getFoldersize "%systemdrive%\Windows\prefetch\"
echo.
echo Do you really want to delete all files?
set /P varPRE=" (y/n) > "
IF /i "%varPRE%"=="y" goto CLPREY
goto TEMPCLEAN
:CLPREY
del %systemdrive%\Windows\prefetch\*.*/s/q > nul
call :LOADLOOP
cls
echo ################################################################## 
echo #                ! PREFETCH FILES CLEANED UP !                   #
echo ##################################################################
echo.
call :getFoldersize "%systemdrive%\Windows\prefetch\"
echo.
pause
goto TEMPCLEAN
:DELWINUC
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                 WINDOWS UPDATE CHACHE CLEANER                  #
echo ##################################################################
echo.
call :getFoldersize "%Systemdrive%\Windows\SoftwareDistribution\Download"
echo.
echo Do you really want to delete all files?
set /P varWUC=" (y/n) > "
IF /i "%varWUC%"=="y" goto DELWINUY
goto TEMPCLEAN
:DELWINUY
del %Systemdrive%\Windows\SoftwareDistribution\Download\*.*/s/q > nul
call :LOADLOOP-a1b2
cls
echo ################################################################## 
echo #              ! WINDOWS UPDATE CHACHE CLEANED UP !              #
echo ##################################################################
echo.
call :getFoldersize "%Systemdrive%\Windows\SoftwareDistribution\Download"
echo.
pause
goto TEMPCLEAN
:DELICTHU
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #               ICON AND THUMBNAIL CACHE CLEANER                 #
echo ##################################################################
echo.
call :getFoldersize "%homepath%\AppData\Local\Microsoft\Windows\Explorer"
echo.
echo Do you really want to delete all files?
set /P varICTH=" (y/n) > "
IF /i "%varICTH%"=="y" goto ICTHDEL
goto TEMPCLEAN
:ICTHDEL
cd %homepath%\AppData\Local\Microsoft\Windows\Explorer > nul
taskkill /f /im explorer.exe > nul
del iconcache* > nul
del thumbcache_*.db > nul
call :LOADLOOP
explorer.exe > nul
cls
echo ################################################################## 
echo #             ! ICON AND THUMBNAIL CACHE CLEANED UP !            #
echo ##################################################################
echo.
call :getFoldersize "%homepath%\AppData\Local\Microsoft\Windows\Explorer"
echo.
pause
goto TEMPCLEAN
:EDGCC
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                     MS EDGE CACHE CLEANER                      #
echo ##################################################################
echo.
call :getFoldersize "%homepath%\AppData\Local\Microsoft\Edge\User Data\Default\Cache\Cache_Data" 
echo.
echo Do you really want to delete all files?
set /P varEDCC=" (y/n) > "
IF /i "%varEDCC%"=="y" goto EDCCY
goto TEMPCLEAN
:EDCCY
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                     MS EDGE CACHE CLEANER                      #
echo ##################################################################
echo #        ! IT IS RECOMMENDED TO CLOSE MS EDGE IF OPEN !          #
echo.
timeout /t 300
tasklist | find /i "msedge.exe" && taskkill /im msedge.exe /F > nul
cd %homepath%\AppData\Local\Microsoft\Edge\User Data\Default\Cache\Cache_Data\ & del *.* /q /s /f  > nul
call :LOADLOOP
cls
echo ################################################################## 
echo #                   ! MS EDGE CACHE CLEANED !                    #
echo ##################################################################
echo.
call :getFoldersize "%homepath%\AppData\Local\Microsoft\Edge\User Data\Default\Cache\Cache_Data" 
echo.
pause
goto TEMPCLEAN
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::: PAGE2 ::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:PAGE2
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                          Main Menu 2                           #
echo ##################################################################
echo.
echo Enter the number to start your desired method.
echo.
echo 1  -- Testing Tools
echo 2  -- Reset PC 
echo 3  -- Install NET Framework 3.5
echo 4  -- ProductKey 
echo 5  -- Win11 Bypass 
echo ~
echo 0  -- Main Menu
echo.
set /P varST2="input: "
IF /i "%varST2%"=="1" goto TESTTOOLS
IF /i "%varST2%"=="2" goto RSTWIN10
IF /i "%varST2%"=="3" goto FRMWK
IF /i "%varST2%"=="4" goto PRODKEY
IF /i "%varST2%"=="5" goto BYPS
IF /i "%varST2%"=="0" goto START
goto FAIL

::::::::::::::::::::::::: TESTING :::::::::::::::::::::::::
:TESTTOOLS
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                         TESTING TOOLS                          #
echo ##################################################################
echo.
echo 1 -- Dummy File Generator 
echo ~
echo 0 -- Back
echo.
set /P varTT="input: "
IF /i "%varTT%"=="1" goto DUMMYGEN 
IF /i "%varTT%"=="0" goto PAGE2
goto FAIL
:DUMMYGEN
cls
echo ################################################################## 
echo #                     DUMMY FILE GENERATOR                       #
echo ##################################################################
echo. 
echo What size should the file be?
echo.
echo 0 -- Back
echo.
set /P varFS="Size in byte: " 
IF /i "%varFS%"=="0" goto TESTTOOLS
cls
echo ################################################################## 
echo #                     DUMMY FILE GENERATOR                       #
echo ##################################################################
echo. 
echo Where do you want to create the file?
echo.
echo 0 -- Back
echo.
set /P varFP="Path: " 
IF /i "%varFP%"=="0" goto DUMMYGEN
cd %varFP% 
fsutil file createnew DUMMY %varFS% >nul
cls
echo ################################################################## 
echo #                   ! DUMMY FILE GENERATED !                     #
echo ##################################################################
echo.
echo Path: %varFP% 
echo Size: %varFS%Byte.
pause
goto START
:RSTWIN10
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                           RESET PC                             #
echo ##################################################################
echo #                  After performing the action,                  #
echo #      you will be asked how much of the pc should be reset      #
echo ##################################################################
echo #             ! ! It may lead to complete data loss ! !          #
echo.
echo.
set /P varSYSRST="Do you really want to continue? <y/n>  "
IF /i "%varSYSRST%"=="y" goto SYSRST
goto PAGE2
:SYSRST
systemreset
goto PAGE2
:FRMWK
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  INSTALL .NET FRAMEWORK 3.5                    #
echo ##################################################################
echo #           Make sure you've got an install medium               #
echo ##################################################################
echo.
echo 1 -- Method 1 (dism)
echo 2 -- Method 2 (Powershell)
echo ~
echo 0 -- Back
echo.
set /P varFrWk="Which method do you want to use? "
set /P varFrPa="On which Drive is your installation medium? "
IF /i "%varFrWk%"=="1" dism /online /enable-feature /featurename:netfx3 /all /source:%varFrPa%:\sources\sxs /limitaccess
IF /i "%varFrWk%"=="2" start /b /wait powershell.exe -command Install-WindowsFeature Net-Framework-Core -source %varFrPa%:\sources\sxs
IF /i "%varFrWk%"=="2" start /b /wait powershell.exe -command Get-WindowsFeature 
IF /i "%varFrWk%"=="0" goto PAGE2
pause
goto FRMWK
:PRODKEY
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                     WINDOWS PRODUCT KEY                        #
echo ##################################################################
echo.
echo Enter the number to start your desired method.
echo.
echo 1  -- BIOS Scan
echo 2  -- REGISTRY Scan
echo 3  -- ProductKey Tool
echo ~
echo 0  -- Back
echo.
set /P varPK="input: "
IF /i "%varPK%"=="1" goto BIOS
IF /i "%varPK%"=="2" goto REG
IF /i "%varPK%"=="3" goto PROKEYTO
IF /i "%varPK%"=="0" goto PAGE2
goto FAIL
:BIOS
echo.
wmic path softwarelicensingservice get OA3xOriginalProductKey
pause 
goto PRODKEY
:REG
(echo Set WshShell = CreateObject^("WScript.Shell"^) & echo.MsgBox ConvertToKey^(WshShell.RegRead^("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DigitalProductId"^)^) & echo. & echo.Function ConvertToKey^(Key^) & echo.Const KeyOffset = 52 & echo.i = 28 & echo.Chars = "BCDFGHJKMPQRTVWXY2346789" & echo.Do & echo.Cur = 0 & echo.x = 14 & echo.Do & echo.Cur = Cur * 256 & echo.Cur = Key^(x + KeyOffset^) + Cur & echo.Key^(x + KeyOffset^) = ^(Cur ^\ 24^) And 255 & echo.Cur = Cur Mod 24 & echo.x = x -1 & echo.Loop While x ^>= 0 & echo.i = i -1 & echo.KeyOutput = Mid^(Chars, Cur + 1, 1^) ^& KeyOutput & echo.If ^(^(^(29 - i^) Mod 6^) = 0^) And ^(i ^<^> -1^) Then & echo.i = i -1 & echo.KeyOutput = "-" ^& KeyOutput & echo.End If & echo.Loop While i ^>= 0 & echo.ConvertToKey = KeyOutput & echo.End Function) > ./GetKey.vbs && GetKey.vbs
pause 
goto PRODKEY
:PROKEYTO
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                   WINDOWS PRODUCT KEY TOOL                     #
echo ##################################################################
echo.
echo Enter the number to start your desired method.
echo.
echo 1  -- Key Informations
echo 2  -- Reset Activation-Countdown
echo 3  -- Online Activation
echo 4  -- Offline Activation (Phone)
echo 5  -- Key install
echo 6  -- Key deinstall
echo ~
echo 0  -- Back
echo.
set /P varPKT="input: "
IF /i "%varPKT%"=="0" goto PRODKEY
IF /i "%varPKT%"=="1" set slmgrV=-dlv
IF /i "%varPKT%"=="2" set slmgrV=-rearm
IF /i "%varPKT%"=="3" set slmgrV=-ato
IF /i "%varPKT%"=="4" set slmgrV=-dti
IF /i "%varPKT%"=="5" set slmgrV=-ipk & echo. & set /P varKEY="insert Key with hyphen: "
IF /i "%varPKT%"=="6" goto SLMGRDE
echo.
slmgr %slmgrV% %varKEY%
pause
goto PROKEYTO
:SLMGRDE
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                 WINDOWS PRODUCT KEY DEINSTALL                  #
echo ##################################################################
echo #        Do you really want to deinstall your Product-Key?       #
echo.
set /P varPKDE=" (y/n) > "
IF /i "%varPKDE%"=="y" (set slmgrV=-upk) else (goto PROKEYTO)
slmgr %slmgrV%
goto PROKEYTO
:BYPS
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                 WINDOWS 11 REQUIREMENTS BYPASS                 #
echo ##################################################################
echo.
echo Enter the number to start your desired method.
echo.
echo 1  -- Bypass Windows 11 Hardware-Requirements (unofficial)
echo 2  -- Reset Win11 Requirements Bypass
echo 3  -- Bypass Windows 11 TPM (Microsoft official)
echo 4  -- Reset Win11 TPM Bypass
echo ~
echo 0  -- Back
echo.
set /P varBYP="input: "
IF /i "%varBYP%"=="1" goto BYWREQ
IF /i "%varBYP%"=="2" goto RSTWREQ
IF /i "%varBYP%"=="3" goto BYWTPM
IF /i "%varBYP%"=="4" goto RSTWTPM
IF /i "%varBYP%"=="0" goto PAGE2
goto FAIL
:BYWREQ
cls
reg add HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig /v BypassTPMCheck /t REG_DWORD /d 00000001 /f >NUL
reg add HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig /v BypassSecureBootCheck /t REG_DWORD /d 00000001 /f >NUL
reg add HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig /v BypassRAMCheck /t REG_DWORD /d 00000001 /f >NUL
reg add HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig /v BypassStorageCheck /t REG_DWORD /d 00000001 /f >NUL
reg add HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig /v BypassCPUCheck /t REG_DWORD /d 00000001 /f >NUL
cls
echo ##################################################################
echo #             WINDOWS 11 REQUIREMENTS BYPASS -   ACTIVE          #
echo ##################################################################
pause
goto BYPS
:RSTWREQ
cls
reg delete HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig /va /f >NUL
reg delete HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig /f >NUL
cls
echo ##################################################################
echo #             WINDOWS 11 REQUIREMENTS BYPASS - INACTIVE          #
echo ##################################################################
pause
goto BYPS
:BYWTPM
cls
reg add HKEY_LOCAL_MACHINE\SYSTEM\Setup\MoSetup /v AllowUpgradesWithUnsupportedTPMOrCPU /t REG_DWORD /d 00000001 /f >NUL
cls
echo ##################################################################
echo #                 WINDOWS 11 TPM BYPASS -   ACTIVE               #
echo ################################################################## 
pause
goto BYPS
:RSTWTPM
cls
reg delete HKEY_LOCAL_MACHINE\SYSTEM\Setup\MoSetup /va /f >NUL
reg delete HKEY_LOCAL_MACHINE\SYSTEM\Setup\MoSetup /f >NUL
cls
echo ##################################################################
echo #                 WINDOWS 11 TPM BYPASS - INACTIVE               #
echo ################################################################## 
pause
goto BYPS
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::: END :::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:REBOOTCHECK
echo REBOOT now, return to the MAIN MENU or EXIT?
echo.
echo 1  -- MAIN MENU
echo 0  -- EXIT
echo 01 -- REBOOT (Recommended)
echo.
set /P varRBC="input: "
IF /i "%varRBC%"=="1" goto START
IF /i "%varRBC%"=="0" goto EXIT
IF /i "%varRBC%"=="01" goto REBOOT
goto FAIL
:REBOOT
cls
echo ################################################################## 
echo #        ! ITS RECOMMENDED TO CLOSE ALL OPEN PROGRAMS !          #
echo ##################################################################
echo. 
timeout /t 300
echo.
set /P varRBC="Reboot now? <y/n> "
IF /i "%varRBC%"=="y" goto REBOOTY
goto START
:REBOOTY
shutdown /r /t 0 /c "WinFixToolbar" >NUL
exit
:EXIT
exit
::::::::::::::::::::::::: ABOUT ::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::: & ::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::: DEBUG ::::::::::::::::::::::::::::::::::::::
:FAIL
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #           TueftelTyp (c)2023       github.com/TueftelTyp       #
echo #                         MIT LICENSE                            #
echo ##################################################################
echo #          Your entry was incorrect, please try again.           #
echo #  You will be returned to the home page by pressing a button!   #
echo ##################################################################
pause >NUL
goto START 
:ABOUT
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #           TueftelTyp (c)2023       github.com/TueftelTyp       #
echo ##################################################################
echo #                         MIT LICENSE                            #
echo ##################################################################
echo.
echo 1  -- MAIN MENU
echo 2  -- GITHUB
echo 9  -- LOOPSIM
echo ~
echo 0  -- EXIT
echo.
set /P varAB="input: "
IF /i "%varAB%"=="1" goto START
IF /i "%varAB%"=="2" start msedge www.github.com/TueftelTyp & goto :ABOUT
IF /i "%varAB%"=="9" goto LOADLOOP
IF /i "%varAB%"=="0" goto EXIT
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::: FUNCTION :::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:getFoldersize  %1=Folderpath
for /f "tokens=*" %%a in ('dir /s "%~1\" ^|find "Datei(en),"') do (set "foldersum=%%a")
echo %foldersum%
exit /b
:LOADLOOP
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [          ]                    #
echo ##################################################################
timeout /t 1 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [#         ]                    #
echo ##################################################################
timeout /t 1 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [##        ]                    #
echo ##################################################################
timeout /t 1 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [###       ]                    #
echo ##################################################################
timeout /t 2 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [####      ]                    #
echo ##################################################################
timeout /t 1 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [#####     ]                    #
echo ##################################################################
timeout /t 1 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [######    ]                    #
echo ##################################################################
timeout /t 1 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [#######   ]                    #
echo ##################################################################
timeout /t 1 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [########  ]                    #
echo ##################################################################
timeout /t 1 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [######### ]                    #
echo ##################################################################
timeout /t 1 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [##########]                    #
echo ##################################################################
timeout /t 2 /nobreak > nul
exit /b
:JOBDONE
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                       ! TASK COMPLETED !                       #
echo ##################################################################
pause
exit /b
