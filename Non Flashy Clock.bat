@echo off
:: This was made because if a program is on full screen on my main screen,
:: I can put this program on my other screen so I can look at the time. 
cls
:TOP
:: Clear Text without using CLS (So there are no flash)
for /F "tokens=1 delims=# " %%a in ('"prompt #$H# & echo on & for %%b in (1) do rem"') do set "BSPACE=%%a"
:: Provides the means to hide the mouse cursor using %esc%[?25l
for /F "delims=#" %%b in ('prompt #$E# ^& for %%b in ^(1^) do rem') do set esc=%%b

:: Change time to replace the text below with %time%%esc%[?25l if you want to see miliseconds too.
:: Default: %time:~-11,2%:%time:~-8,2%:%time:~-5,2%%esc%[?25l
<nul set /p =%time:~-11,2%:%time:~-8,2%:%time:~-5,2%%esc%[?25l
title %time:~-11,2%:%time:~-8,2%:%time:~-5,2%
<nul set /p =%BSPACE%%BSPACE%%BSPACE%%BSPACE%%BSPACE%%BSPACE%%BSPACE%%BSPACE%
goto :TOP
