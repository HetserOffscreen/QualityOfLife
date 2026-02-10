@echo off
setlocal enabledelayedexpansion
color 0E
cls
title PROTOCOL: ZEE_TOILLETE

:: --- HEADER ---
echo.
echo   ______  ______  ______     
echo  ^|___  /^ ^|  ____^|^|  ____^|    
echo     / /  ^| ^|__   ^| ^|__       
echo    / /   ^|  __^|  ^|  __^|      
echo   / /__  ^| ^|____ ^| ^|____     
echo  /_____^|^|_______^|^|_______^|    
echo.
echo   _______  _____   _____  _        _        ______  _______  ______ 
echo  ^|__   __^|^|  _  ^| ^|_   _^|^| ^|      ^| ^|      ^|  ____^|^|__   __^|^|  ____^|
echo     ^| ^|   ^| ^| ^| ^|   ^| ^|  ^| ^|      ^| ^|      ^| ^|__      ^| ^|   ^| ^|__   
echo     ^| ^|   ^| ^| ^| ^|   ^| ^|  ^| ^|      ^| ^|      ^|  __^|     ^| ^|   ^|  __^|  
echo     ^| ^|   \ \_/ /  _^| ^|_ ^| ^|____  ^| ^|____  ^| ^|____    ^| ^|   ^| ^|____ 
echo     ^|_^|    \___/  ^|_____^|^|______^| ^|______^| ^|______^|   ^|_^|   ^|______^|
echo.
echo   Made by Hetser Offscreen
echo.

:: --- SCANNING (Animation moved here) ---
echo Looking For Shit...
call :loadingbar

:: Define potential targets
set "target1=%APPDATA%\stremio\stremio-server\stremio-cache"
set "target2=%LOCALAPPDATA%\stremio\stremio-server\stremio-cache"
set "final_target="

:: Logic: Find which one exists
if exist "%target1%" set "final_target=%target1%"
if exist "%target2%" set "final_target=%target2%"

:: If neither found, go to detailed report
if not defined final_target goto clean_exit

:: --- CALCULATE SIZE ---
set "size=0"
for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command "try { [math]::Round(((Get-ChildItem -LiteralPath '%final_target%' -Recurse -Force -ErrorAction Stop | Measure-Object -Property Length -Sum).Sum / 1MB), 2) } catch { 0 }"`) do set "size=%%A"

echo.
echo  [+] TURD SIZE DETECTED: !size! MB
echo.

:: --- CONFIRMATION ---
set /p "ask=Flush this turd? (y/n): "
if /i not "!ask!"=="y" goto abort

:: --- ANIMATIONS ---
echo.
echo Cleaning Piracy Data...
call :loadingbar

echo.
echo Flushing Your...
timeout /t 4 /nobreak >nul
call :shittybar

:: --- CLEANUP ---
taskkill /F /IM stremio.exe >nul 2>&1
rd /s /q "%final_target%"

echo.
echo Done! Your crap has been cleaneded.

:: --- SOUND & EXIT ---
:: Console Beep
cmd /c "echo "
goto end_script

:clean_exit
echo.
echo  [Roaming] SECTOR CLEAR
echo  [Local]   SECTOR CLEAR
echo.
echo  [!] SYSTEM CLEAN.
goto end_script

:abort
echo.
echo  [!] ABORTING. THE CRAP REMAINS.
goto end_script

:end_script
echo.
echo Press any key to exit...
pause >nul
exit /b

:: --- VISUALS ---
:loadingbar
set /p ="Status: " <nul
timeout /t 2 /nobreak >nul
set /p ="[" <nul
for /L %%x in (1,1,40) do (
    set /p ="/" <nul
    ping localhost -n 1 -w 80 >nul
)
echo ] OK.
exit /b

:shittybar
set /p ="Shit: " <nul
timeout /t 2 /nobreak >nul
set /p ="[" <nul
for /L %%x in (1,1,120) do (
    set /p ="/" <nul
    ping localhost -n 1 -w 80 >nul
)
echo ] OK.
exit /b