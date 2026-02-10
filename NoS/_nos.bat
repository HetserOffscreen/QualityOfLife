@echo off
setlocal enabledelayedexpansion
:: FORCE UTF-8
chcp 65001 >nul

title NoS SYSTEM UTILITY
color 70
mode con: cols=65 lines=22

:MENU
cls
echo.
echo   ╔══════════[ NoS SYSTEM UTILITY ]══════════╤══════════════╗
echo   ║                                          │              ║
echo   ║   [1] FLUSH DNS CACHE                    │  STATUS      ║
echo   ║   [2] RENEW IP ADDRESS                   │  ----------  ║
echo   ║   [3] PING TEST (LATENCY)                │  [ONLINE]    ║
echo   ║   [4] SPEED TEST                         │              ║
echo   ║   [5] SHOW PUBLIC IP                     │  USER:       ║
echo   ║                                          │  Admin       ║
echo   ║   [Q] QUIT SYSTEM                        │              ║
echo   ║                                          │              ║
echo   ╟──────────────────────────────────────────┴──────────────╢
echo   ║  Made by Hetser Offscreen                      v2.1     ║
echo   ╚═════════════════════════════════════════════════════════╝
echo    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
echo.

set /p "opt=   SELECT OPTION > "

if /i "%opt%"=="q" exit
if "%opt%"=="5" goto PUBLICIP
if "%opt%"=="4" goto SPEED
if "%opt%"=="3" goto PING
if "%opt%"=="2" goto RENEW
if "%opt%"=="1" goto FLUSH
goto MENU

:FLUSH
cls
echo.
echo   [ EXECUTION ] FLUSHING DNS CACHE...
echo   -----------------------------------
ipconfig /flushdns
echo.
echo   [!] OPERATION COMPLETE.
pause >nul
goto MENU

:RENEW
cls
echo.
echo   [ EXECUTION ] RENEWING IP ADDRESS...
echo   ------------------------------------
echo   Please wait. This may cut your connection.
ipconfig /release >nul
ipconfig /renew >nul
echo.
echo   [!] IP ADDRESS RENEWED.
pause >nul
goto MENU

:PING
cls
echo.
echo   [ EXECUTION ] PING TEST (8.8.8.8)
echo   ---------------------------------
ping 8.8.8.8 -n 4
echo.
echo   [!] DIAGNOSTIC COMPLETE.
pause >nul
goto MENU

:SPEED
cls
echo.
echo   [ EXECUTION ] LAUNCHING SPEED TEST...
start https://fast.com
goto MENU

:PUBLICIP
cls
echo.
echo   [ EXECUTION ] RETRIEVING PUBLIC IP...
echo   -------------------------------------
echo.
echo   YOUR EXTERNAL IP IS:
curl -s ifconfig.me
echo.
echo.
echo   -------------------------------------
pause >nul
goto MENU