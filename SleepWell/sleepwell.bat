@echo off
setlocal enabledelayedexpansion

:: --- 1. VISUAL SETUP ---
:: Color 09 = Black Background, Light Blue Text
color 09
title SleepWell Timer
:: Disable QuickEdit to prevent mouse clicks from freezing the timer
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 0 /f >nul

:: --- 2. CREATE VOLUME HELPER (VBScript) ---
:: We write a tiny script to the Temp folder that presses "Volume Down" once.
set "vbs_file=%temp%\sleepwell_vol.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%vbs_file%"
echo WshShell.SendKeys(chr(^&hAE)) >> "%vbs_file%"

:: --- 3. ANSI ESCAPE SETUP (Anti-Flicker) ---
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "ESC=%%b"
)

:menu
cls
set "minutes="
echo.
echo    .      * .       .          * .
echo        ______ _                  _       __     _ _ 
echo       / ____^| ^|                ^| ^|     / /    ^| ^| ^|
echo      ^| (___ ^| ^| ___  ___ _ __  ^| ^|    / /_ ___^| ^| ^|
echo       \___ \^| ^|/ _ \/ _ \ '_ \ ^| ^|   / / _/ _ \ ^| ^|
echo   * ____) ^| ^|  __/  __/ ^|_) ^|^| ^|__/ /^|  __/ ^| ^| ^|
echo      ^|_____/^|_^|\___^|\___^| .__/ ^|____/  \___^|_^|_^|_^|
echo          .            ^| ^|       * .
echo        * ^|_^|   v2.0
echo.
echo      Made by Hetser Offscreen
echo.
echo    =========================================
echo    [1] 15 Minutes
echo    [2] 30 Minutes
echo    [3] 60 Minutes
echo    [X] Exit
echo    =========================================
echo.
choice /C 123X /N /M "Select Duration > "

if errorlevel 4 exit
if errorlevel 3 set minutes=60
if errorlevel 2 set minutes=30
if errorlevel 1 set minutes=15

:: Calculation
set /a seconds=%minutes%*60
set /a total_seconds=%seconds%

:: Determine Volume Decay Rate
:: We want to hit 0 volume by the end.
:: Windows has 100 volume steps.
:: If we drop volume every 'X' seconds, we get a smooth fade.
set /a drop_interval=%total_seconds% / 50
if %drop_interval% LSS 1 set drop_interval=1

cls

:countdown
:: --- VISUALS ---
echo %ESC%[1;1H
echo.
echo    .      * .       .          * .
echo        ______ _                  _       __     _ _ 
echo       / ____^| ^|                ^| ^|     / /    ^| ^| ^|
echo      ^| (___ ^| ^| ___  ___ _ __  ^| ^|    / /_ ___^| ^| ^|
echo       \___ \^| ^|/ _ \/ _ \ '_ \ ^| ^|   / / _/ _ \ ^| ^|
echo   * ____) ^| ^|  __/  __/ ^|_) ^|^| ^|__/ /^|  __/ ^| ^| ^|
echo      ^|_____/^|_^|\___^|\___^| .__/ ^|____/  \___^|_^|_^|_^|
echo          .            ^| ^|       * .
echo        * ^|_^|   v2.0
echo.
echo      Made by Hetser Offscreen
echo.
echo    -----------------------------------------
echo     Time Remaining: %seconds% seconds
echo    -----------------------------------------
echo.
echo     [ Press 'X' to Cancel / Return to Menu ]
echo.

:: --- BAR GRAPH ---
set /a bar_width=(%seconds% * 40) / %total_seconds%
set "bar="
for /L %%A in (1,1,%bar_width%) do set "bar=!bar!Û"
set /a spaces=40-%bar_width%
for /L %%B in (1,1,!spaces!) do set "bar=!bar! "

echo     [!bar!]
echo.

:: --- AUDIO FADE LOGIC ---
:: Calculate modulo to see if we should drop volume this second
set /a "mod=%seconds% %% %drop_interval%"
if %mod%==0 (
    cscript //nologo "%vbs_file%" >nul
)

:: --- TIMER & INPUT ---
:: Wait 1 sec, check for X
choice /C XN /N /T 1 /D N >nul
if errorlevel 2 goto decrement
if errorlevel 1 goto abort

:decrement
set /a seconds-=1
if %seconds% LEQ 0 goto shutdown
title SleepWell: %seconds%s left
goto countdown

:abort
cls
echo.
echo    Timer Cancelled.
echo    Returning to menu...
:: Clean up standard mouse behavior before menu
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f >nul
timeout /t 2 /nobreak >nul
goto menu

:shutdown
:: Cleanup VBS file
del "%vbs_file%" >nul 2>&1
cls
color 01
echo.
echo    .    * .
echo       Goodnight.
echo    * .    *
timeout /t 3 /nobreak >nul
shutdown /s /t 0