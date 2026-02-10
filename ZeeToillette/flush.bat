@echo off
setlocal enabledelayedexpansion
title Protocol: Zee Toillette
color 0E

:: --- INIT ---
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "ESC=%%b"

:HEADER
cls
echo.
echo   o  .   O   .  ______  ______  ______   .   o   .   O   .   o
echo     .   o   .  ^|___  /^ ^|  ____^|^|  ____^| .   O   .   o   .   O
echo   O   .   o      / /  ^| ^|__   ^| ^|__      .   o   .   O   .
echo     .   O       / /   ^|  __^|  ^|  __^|    o    .   o     .   o
echo   o   .   o    / /__  ^| ^|____ ^| ^|____     .   O   .   o   .
echo     O   .   o /_____^|^|_______^|^|_______^|  o    .   o     .   O
echo   .   o   .   _______  _____   _____  _   .    _   .    ______  _______  ______
echo     .   O    ^|__   __^|^|  _  ^| ^|_   _^|^| ^|   o  ^| ^|   .  ^|  ____^|^|__   __^|^|  ____^|
echo   o   .   o     ^| ^|   ^| ^| ^| ^|   ^| ^|  ^| ^|   .  ^| ^|   o  ^| ^|__      ^| ^|   ^| ^|__
echo     o   .   O   ^| ^|   ^| ^| ^| ^|   ^| ^|  ^| ^|   o  ^| ^|   .  ^|  __^|     ^| ^|   ^|  __^|
echo   .   O   .     ^| ^|   \ \_/ /  _^| ^|_ ^| ^|____  ^| ^|____  ^| ^|____    ^| ^|   ^| ^|____
echo     .   o   .   ^|_^|    \___/  ^|_____^|^|______^| ^|______^| ^|______^|   ^|_^|   ^|______^|
echo   o   .   O   .      o     .      O    .     o      .    O     .
echo                                       o     by Hetser Offscreen  .
echo.

:SCAN_TARGETS
echo   Looking For Shit...
call :ANIM_LOADING

set "t1=%APPDATA%\stremio\stremio-server\stremio-cache"
set "t2=%LOCALAPPDATA%\stremio\stremio-server\stremio-cache"
if exist "%t1%" (set "target=%t1%") else (if exist "%t2%" (set "target=%t2%") else (goto EXIT_CLEAN))

:CALC_SIZE
set "size=0"
for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command "try { [math]::Round(((Get-ChildItem -LiteralPath '%target%' -Recurse -Force -ErrorAction Stop | Measure-Object -Property Length -Sum).Sum / 1MB), 2) } catch { 0 }"`) do set "size=%%A"

echo.
echo   [+] TURD SIZE DETECTED: %size% MB
echo.

:PROMPT_USER
set /p "ask=   Flush this turd? (y/n) > "
if /i not "!ask!"=="y" goto EXIT_ABORT

:FLUSH_PROCESS
echo.
echo   Cleaning Piracy Data...
call :ANIM_LOADING

echo.
echo   Flushing Your...
timeout /t 2 /nobreak >nul
call :ANIM_FLUSHING

taskkill /F /IM stremio.exe >nul 2>&1
rd /s /q "%target%"

echo.
echo   Done! Your crap has been cleaned.
cmd /c "echo "
goto EXIT_Done

:EXIT_CLEAN
echo.
echo   [Roaming] SECTOR CLEAR
echo   [Local]   SECTOR CLEAR
echo.
echo   [!] SYSTEM CLEAN.
goto EXIT_DONE

:EXIT_ABORT
echo.
echo   [!] ABORTING. THE CRAP REMAINS.
goto EXIT_DONE

:EXIT_DONE
echo.
echo   Press any key to exit...
pause >nul
exit /b

:ANIM_LOADING
set /p ="   Status: " <nul
timeout /t 1 /nobreak >nul
set /p ="[" <nul
for /L %%x in (1,1,40) do (
    set /p ="/" <nul
    ping localhost -n 1 -w 50 >nul
)
echo ] OK.
exit /b

:ANIM_FLUSHING
set /p ="   Shit: " <nul
timeout /t 1 /nobreak >nul
set /p ="[" <nul
for /L %%x in (1,1,60) do (
    set /p ="/" <nul
    ping localhost -n 1 -w 50 >nul
)
echo ] OK.
exit /b