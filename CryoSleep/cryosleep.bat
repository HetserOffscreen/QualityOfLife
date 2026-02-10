@echo off
setlocal enabledelayedexpansion

:: --- 1. DISABLE QUICK EDIT (Mouse clicks won't freeze time) ---
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 0 /f >nul

:: --- 2. SETUP ANSI ESCAPE (No Flicker) ---
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "ESC=%%b"
)

:menu
cls
color 0B
title PROTOCOL: CRYOSLEEP // CONFIG
:: ASCII HEADER (Static for Menu)
echo.
echo    _____ ______     ______   _____ _      ______ ______ _____  
echo   / ____^|  ____^|   / __ \ \ / / _ \ ^|    ^|  ____^|  ____^|  __ \ 
echo  ^| ^|    ^| ^|__     ^| ^|  ^| \ V / ^| ^| ^| ^|    ^| ^|__  ^| ^|__  ^| ^|__) ^|
echo  ^| ^|    ^|  __^|    ^| ^|  ^| ^| ^> ^< ^| ^| ^| ^|    ^|  __^| ^|  __^| ^|  ___/ 
echo  ^| ^|____^| ^| ^| ^|____^| ^|__^| ^|/ . \ ^|_^| ^|____^| ^|____^| ^|____^| ^|     
echo   \_____^|_^|  \______\____/_/ \_\___/______^|______^|______^|_^|     
echo.
echo =========================================================
echo    SELECT HIBERNATION DURATION:
echo =========================================================
echo.
echo    [1] 15 Minutes
echo    [2] 30 Minutes
echo    [3] 60 Minutes
echo.
set /p choice="INPUT [1-3]: "

if "%choice%"=="1" set minutes=15
if "%choice%"=="2" set minutes=30
if "%choice%"=="3" set minutes=60
if not defined minutes goto menu

set /a seconds=%minutes%*60
set /a total_seconds=%seconds%
set "panic_mode=0"

cls

:countdown
:: --- COLOR LOGIC ---
if %seconds% LEQ 600 (
    if "!panic_mode!"=="0" (
        color 0C
        set "panic_mode=1"
    )
)

:: --- BAR MATH ---
set /a bar_width=(%seconds% * 50) / %total_seconds%
if %bar_width% LSS 0 set bar_width=0

set "bar=["
for /L %%A in (1,1,%bar_width%) do (
    set "bar=!bar!#"
)
set /a spaces=50-%bar_width%
for /L %%B in (1,1,!spaces!) do (
    set "bar=!bar! "
)
set "bar=!bar!]"

:: --- DRAWING (Cursor Reset to Top) ---
echo %ESC%[1;1H
echo.
:: ASCII HEADER (Inside Loop)
echo    _____ ______     ______   _____ _      ______ ______ _____  
echo   / ____^|  ____^|   / __ \ \ / / _ \ ^|    ^|  ____^|  ____^|  __ \ 
echo  ^| ^|    ^| ^|__     ^| ^|  ^| \ V / ^| ^| ^| ^|    ^| ^|__  ^| ^|__  ^| ^|__) ^|
echo  ^| ^|    ^|  __^|    ^| ^|  ^| ^| ^> ^< ^| ^| ^| ^|    ^|  __^| ^|  __^| ^|  ___/ 
echo  ^| ^|____^| ^| ^| ^|____^| ^|__^| ^|/ . \ ^|_^| ^|____^| ^|____^| ^|____^| ^|     
echo   \_____^|_^|  \______\____/_/ \_\___/______^|______^|______^|_^|     
echo.
echo   TIME REMAINING: %seconds% Seconds   
echo.
echo   OXYGEN: %bar%
echo.
echo   [ PRESS 'X' TO ABORT IMMEDIATELY ]
echo.

:: --- TIMER & INPUT LOGIC ---
:: Waits 1 second. Defaults to N. If X is pressed, goes to Abort.
choice /C XN /N /T 1 /D N >nul
if errorlevel 2 goto decrement
if errorlevel 1 goto abort

:decrement
set /a seconds-=1
if %seconds% LEQ 0 goto shutdown
title CRYOSLEEP: %seconds% Seconds Remaining
goto countdown

:abort
cls
color 0E
echo.
echo   ABORT CODE RECEIVED.
echo   SYSTEM RESUMING NORMAL OPERATIONS.
echo.
:: Restore Mouse Settings
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f >nul
pause
exit

:shutdown
cls
color 4F
echo.
echo   SYSTEM FAILURE.
echo   GOODNIGHT.
timeout /t 3 /nobreak >nul
shutdown /s /t 0