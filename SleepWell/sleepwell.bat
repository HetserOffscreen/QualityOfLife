@echo off
setlocal enabledelayedexpansion
title SleepWell
color 09

:: --- INIT ---
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 0 /f >nul
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "ESC=%%b"

:: --- VBS GENERATOR ---
set "vbs=%temp%\sw_vol.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%vbs%"
echo WshShell.SendKeys(chr(^&hAE)) >> "%vbs%"

:MENU
cls
echo.
echo   * .  +  .  * .  +   .  * .  +  .  * .  +   .  * .  +  .  *
echo    +  .  * .  +   .  * .  +   .  * .  +   .  * .  +   .  * .
echo      .   * .       .    * .         .      * .    +      .   * .   +
echo     * _____ __               _       __     ____      * .  +   .   *
echo   +    / ___// /__  ___  ____ ^| ^|     / /__  / / /    .      +   * .
echo    .   \__ \/ / _ \/ _ \/ __ \^| ^| /^| / / _ \/ / /   * .   .   +    *
echo    * .___/ / /  __/  __/ /_/ /^| ^|/ ^|/ /  __/ / /      +     * .   +
echo   +  /____/_/\___/\___/ .___/ ^|__/ ^|__/\___/_/_/  .      .   * .
echo    .      .         /_/   * .       * .     * +    .    * +    .
echo   * .  +  .  * .  +   .                  by Hetser Offscreen  * +
echo    +  .  * .  +   .  * .  +   .  * .  +   .  * .  +   .  * .
echo   * .  +  .  * .  +   .  * .  +  .  * .  +   .  * .  +  .  *
echo.
echo    [1] 15 Minutes
echo    [2] 30 Minutes
echo    [3] 60 Minutes
echo    [4] 90 Minutes
echo    [X] Exit
echo.
choice /C 1234X /N /M "Select > "

if errorlevel 5 goto CLEANUP
if errorlevel 4 set "mins=90"
if errorlevel 3 set "mins=60"
if errorlevel 2 set "mins=30"
if errorlevel 1 set "mins=15"

:: --- CONFIG ---
set /a secs=%mins%*60
set /a total=%secs%
set /a drop=%total%/50
if %drop% LSS 1 set drop=1

cls

:TIMER_LOOP
:: --- RENDER ---
echo %ESC%[1;1H
echo.
echo   * .  +  .  * .  +   .  * .  +  .  * .  +   .  * .  +  .  *
echo    +  .  * .  +   .  * .  +   .  * .  +   .  * .  +   .  * .
echo      .   * .       .    * .         .      * .    +      .   * .   +
echo     * _____ __               _       __     ____      * .  +   .   *
echo   +    / ___// /__  ___  ____ ^| ^|     / /__  / / /    .      +   * .
echo    .   \__ \/ / _ \/ _ \/ __ \^| ^| /^| / / _ \/ / /   * .   .   +    *
echo    * .___/ / /  __/  __/ /_/ /^| ^|/ ^|/ /  __/ / /      +     * .   +
echo   +  /____/_/\___/\___/ .___/ ^|__/ ^|__/\___/_/_/  .      .   * .
echo    .      .         /_/   * .       * .     * +    .    * +    .
echo   * .  +  .  * .  +   .                  by Hetser Offscreen  * +
echo    +  .  * .  +   .  * .  +   .  * .  +   .  * .  +   .  * .
echo   * .  +  .  * .  +   .  * .  +  .  * .  +   .  * .  +  .  *
echo.
echo    ----------------------------------------
echo     Time Remaining: %secs%s
echo    ----------------------------------------
echo.
echo     [ Press 'X' to Cancel ]
echo.

:: --- BAR ---
set /a width=(%secs%*40)/%total%
set "bar="
for /L %%A in (1,1,%width%) do set "bar=!bar!|"
set /a space=40-%width%
for /L %%B in (1,1,!space!) do set "bar=!bar! "

echo     [!bar!]
echo.

:: --- FADE LOGIC ---
set /a "mod=%secs% %% %drop%"
if %mod%==0 cscript //nologo "%vbs%" >nul

:: --- TICK ---
choice /C XN /N /T 1 /D N >nul
if errorlevel 2 goto DECREMENT
if errorlevel 1 goto ABORT

:DECREMENT
set /a secs-=1
if %secs% LEQ 0 goto SHUTDOWN
goto TIMER_LOOP

:ABORT
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f >nul
goto MENU

:SHUTDOWN
del "%vbs%" >nul 2>&1
shutdown /s /t 0
exit

:CLEANUP
del "%vbs%" >nul 2>&1
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f >nul
exit