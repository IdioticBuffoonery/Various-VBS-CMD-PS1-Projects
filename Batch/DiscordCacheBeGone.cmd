@echo off
title Discord CacheBeGone

:: This isn't really recommended to use this unless you know what you're doing.
:: I just needed a way to test a theory of Discord Caching issues.  

set CC=0
set CCC=0
set CGPUC=0
:START
if exist "C:\Users\%username%\AppData\Roaming\discord\Cache" (
    set /A CC=CC+1
    echo [%CC%] Cleaning Cache
    rd /S /Q "C:\Users\%username%\AppData\Roaming\discord\Cache"
)
if exist "C:\Users\%username%\AppData\Roaming\discord\Code Cache" (
    set /A CCC=CCC+1
    echo [%CCC%] Cleaning Code Cache
    rd /S /Q "C:\Users\%username%\AppData\Roaming\discord\Code Cache"
)
if exist "C:\Users\%username%\AppData\Roaming\discord\GPUCache" (
    set /A CGPUC=CGPUC+1
    echo [%CGPUC%] Cleaning GPU Cache
    rd /S /Q "C:\Users\%username%\AppData\Roaming\discord\GPUCache"
)
goto :START
exit
