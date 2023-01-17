:: TüftelTyp ®2023
:: github.com/TueftelTyp
@echo off
title Simple Windows Toolbox
::mode con cols=69 lines=26 >nul ::Windowsize
mode 70,30
color 0A
:START
cls
echo ################################################################## 
echo #                 - Simple Windows Toolbox -                     #
echo #                          Main Menu                             #
echo ##################################################################
echo # Make sure that the application is running as an administrator. #
echo ##################################################################
echo.
echo Enter the number to start your desired method.
echo.
echo 1  -- Windows Testmode
echo 2  -- Integrity Checks
echo 3  -- System File Check
echo ~
::echo 4  --  
::echo 5  --   
echo 6  -- Release/Renew DHCP Lease 
echo 7  -- File Cleaner 
echo 8  -- Reseted Settings Fix 
echo.
echo 9  -- Next Page
echo.
echo 0  -- Exit
echo 01 -- Reboot (recommended after changes)
echo.
set /P varST="input: "

IF /i "%varST%"=="1" goto TESTMODE
IF /i "%varST%"=="2" goto INTEGRITY
IF /i "%varST%"=="3" goto SFC
IF /i "%varST%"=="4" goto 
IF /i "%varST%"=="5" goto 
IF /i "%varST%"=="6" goto DHCPLEASE
IF /i "%varST%"=="7" goto TEMPCLEAN
IF /i "%varST%"=="8" goto RSTSETFIX
IF /i "%varST%"=="9" goto PAGE2
IF /i "%varST%"=="0" goto EXIT
IF /i "%varST%"=="01" goto REBOOT

:TESTMODE
cls
echo ################################################################## 
echo #                 - Simple Windows Toolbox -                     #
echo #                       WINDOWS TESTMODE                         #
echo ##################################################################
echo.
echo Enter the number to START your desired method.
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
echo Enter the number to START your desired method.
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
echo Enter the number to START your desired method.
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
echo 1 -- Clean Users Temporary Files
echo 2 -- Clean Windows Temporary Files
echo 3 -- Clean RecycleBin
echo ~
echo 0 -- Back
echo.
set /P varTFC="input: "
IF /i "%varTFC%"=="1" goto USER
IF /i "%varTFC%"=="2" goto WINDOWS
IF /i "%varTFC%"=="3" goto RECBIN
IF /i "%varTFC%"=="0" goto START
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
cd %Appdata% > nul
cd .. > nul
cd Local > nul
rd Temp /s /q > nul
md Temp > nul
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
cd %systemdrive%/Windows > nul
rd Temp /s /q > nul
md Temp > nul
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
call :getFoldersize "%systemdrive%\$Recycle.Bin%"
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
call :getFoldersize "%systemdrive%\$Recycle.Bin%"
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
::echo 2  -- 
::echo 3  -- 
::echo 4  --  
::echo 5  --   
::echo 6  -- 
::echo 7  -- 
::echo 8  --  
::echo 9  -- Next Page
echo ~
echo 0  -- Main Menu
echo.
set /P varST2="input: "

IF /i "%varST2%"=="1" goto TESTTOOLS
IF /i "%varST2%"=="2" goto 
IF /i "%varST2%"=="3" goto 
IF /i "%varST2%"=="4" goto 
IF /i "%varST2%"=="5" goto 
IF /i "%varST2%"=="6" goto 
IF /i "%varST2%"=="7" goto 
IF /i "%varST2%"=="8" goto 
IF /i "%varST2%"=="9" goto 
IF /i "%varST2%"=="0" goto START



::::::::::::::::::::::::: TESTING :::::::::::::::::::::::::
:TESTTOOLS
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                         TESTING TOOLS                          #
echo ##################################################################
echo.
echo Enter the number to START your desired method.
echo.
echo 1 -- Dummy File Generator
::echo 2 -- 
echo ~
echo 0 -- Back
echo.
set /P varTT="input: "
IF /i "%varTT%"=="1" goto DUMMYGEN
::IF /i "%varTT%"=="2" goto 
IF /i "%varTT%"=="0" goto PAGE2

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
timeout /t 2 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [#         ]                    #
echo ##################################################################
timeout /t 2 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [##        ]                    #
echo ##################################################################
timeout /t 2 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [###       ]                    #
echo ##################################################################
timeout /t 1 /nobreak > nul
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
timeout /t 2 /nobreak > nul
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
timeout /t 2 /nobreak > nul
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                  LOADING...    [##########]                    #
echo ##################################################################
timeout /t 1 /nobreak > nul
exit /b
:JOBDONE
cls
echo ################################################################## 
echo #                  - Simple Windows Toolbox -                    #
echo #                       ! TASK COMPLETED !                       #
echo ##################################################################
pause
exit /b