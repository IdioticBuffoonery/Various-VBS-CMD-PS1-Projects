@echo off
::Appear on top
powershell -ExecutionPolicy UnRestricted -Command "(Add-Type -memberDefinition \"[DllImport(\"\"user32.dll\"\")] public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int x,int y,int cx, int xy, uint flagsw);\" -name \"Win32SetWindowPos\" -passThru )::SetWindowPos((Add-Type -memberDefinition \"[DllImport(\"\"Kernel32.dll\"\")] public static extern IntPtr GetConsoleWindow();\" -name \"Win32GetConsoleWindow\" -passThru )::GetConsoleWindow(),-1,0,0,0,0,67)" >nul
cls

:: Edit this to choose your prefered time mode.
::     "0" = Time Format HH:mm:ss
::     "1" = Time Format HH:mm:ss:SS
:: Default: "0"
set /A timeChoice=0

:TOP
:: Clear Text without using CLS (So there are no flash)
for /F "tokens=1 delims=# " %%a in ('"prompt #$H# & echo on & for %%b in (1) do rem"') do set "BSPACE=%%a"
:: Provides the means to hide the mouse cursor using %esc%[?25l
for /F "delims=#" %%b in ('prompt #$E# ^& for %%b in ^(1^) do rem') do set esc=%%b

::Set time variables
set HH=%time:~-11,2%
set mm=%time:~-8,2%
set ss=%time:~-5,2%
set HHmmss=%HH: =0%:%mm%:%ss%

:: Handles the settings for what time mode a user wants
set timeMode=%HHmmss%
if /i "%timeChoice%"=="0" set timeMode=%HHmmss%
if /i "%timeChoice%"=="1" set timeMode=%time: =0%

:: What you see is what you get.
<nul set /p =%timeMode%%esc%[?25l
title %timeMode%
<nul set /p =%BSPACE%%BSPACE%%BSPACE%%BSPACE%%BSPACE%%BSPACE%%BSPACE%%BSPACE%
goto :TOP

:: This was made because if a program is on full screen on my main screen,
:: I can put this program on my other screen so I can look at the time. 
