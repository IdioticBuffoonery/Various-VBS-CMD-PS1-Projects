$host.ui.RawUI.WindowTitle = "ToggleEthernet"

function Get-PrintBright {
Write-Host "Welcome to ToggleEthernet." -foreground "Yellow"
Write-Host "A simple way to toggle your ethernet!" -foreground "Yellow"
}
function Get-PrintWrongChoice {
clear
Write-Host "Please Enter a Valid Choice, or enter the number 3 to exit." -foreground "Red"
}
function Get-PrintRequired {
clear
Write-Host "You must enter a option, as required!" -foreground "Red"
}

function RestartScript {
    wmic path win32_networkadapter where index=2 call disable
    Start-Sleep -s 2.5
    wmic path win32_networkadapter where index=2 call enable
    echo "Ethernet has been restarted!"
    echo ""
    Start-Sleep -s 5
    confirmScript 
}

function ActivateScript {
    wmic path win32_networkadapter where index=2 call enable
    echo "Ethernet has been activated!"
    echo ""
    Start-Sleep -s 5
    confirmScript 
}

function DeactivateScript {
    wmic path win32_networkadapter where index=2 call disable
    echo "Ethernet has been disabled."
    echo ""
    Start-Sleep -s 5
    confirmScript 
}

function confirmScript {
    clear
    Get-PrintBright
    echo "What do you want to do`:"
    echo ""
    echo "Enter the number `"1`" to restart Ethernet! (This will run 3 and then 2)"
    echo "Enter the number `"2`" to activate Ethernet!"
    echo "Enter the number `"3`" to deactivate Ethernet"
    
    echo "Enter the number `"0`" to exit!"
    echo ""
    $choVar = Read-Host -Prompt ' >'

    if ($choVar -eq "") {
        Get-PrintRequired
    } else { 
        if ($choVar -eq 1) {
	    RestartScript
        }
        if ($choVar -eq 2) {
            ActivateScript
        }
        if ($choVar -eq 3) {
            DeactivateScript
        }
        if ($choVar -eq 0) {
            exit
        }
    Get-PrintWrongChoice 
}
confirmScript
}
confirmScript

