@echo off
title ISUP-CMD
:start
IF EXIST urls.txt (
    for /f %%a in (urls.txt) do (
        powershell write-host ^[ISUP-CMD^] Pinging %%a. -foreground "CYAN"
        ping -n 1 -l 1 %%a | find "Reply" > NUL
        if not errorlevel 1 (
            powershell write-host ^[ISUP-CMD^] %%a is up! -foreground "GREEN"
            title [Is-Up] %%a: Online
            echo.
        ) else (
            powershell write-host ^[ISUP-CMD^] %%a is down. -foreground "RED"
        title [Is-Up] %%a: Offline
            echo.
        )
    )
    PING localhost -n 30 >NUL
    :: Retry every 30 seconds
    cls
    goto :start
) ELSE (
    ECHO google.com>urls.txt
    ECHO example.com>>urls.txt
    ECHO bing.com>>urls.txt
    ECHO fakesubdomain.myexamplewebsite.fake>>urls.txt
    ECHO 127.0.0.1>>urls.txt
    ECHO 8.8.4.4>>urls.txt
    goto :start
)
