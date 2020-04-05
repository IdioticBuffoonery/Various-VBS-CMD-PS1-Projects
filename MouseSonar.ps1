Set-ExecutionPolicy Bypass -Scope Process
$host.ui.RawUI.WindowTitle = "MouseSonar"

function Get-PrintBright {
Write-Host "Welcome to MouseSonar." -foreground "Yellow"
}

function Get-PrintWrongChoice {
clear
Write-Host "Please Enter a Valid Choice, or enter the number 3 to exit." -foreground "Red"
confirmScript
}

function Get-PrintRequired {
clear
Write-Host "You must enter a option, as required!" -foreground "Red"
}

function pause {
cmd /c pause | out-null
}

#The code for 'TurnItOn' and 'TurnItOff' were found on http://forum.notebookreview.com/threads/mouse-sonar-registry-key-show-location-of-pointer-when-i-press-the-ctrl-key.690777/&usg=ALkJrhj7OvTGxmOJoV7G2cMLOfFO7GWRyQ#post-9728286

function TurnItOn {
$signature = @'
[DllImport("user32.dll")]
public static extern bool SystemParametersInfo(
    uint uiAction,
    uint uiParam,
    uint pvParam,
    uint fWinIni);
'@

$SPI_SETMOUSESONAR = 0x101D
$SPIF_UPDATEINIFILE = 0x1
$SPIF_SENDCHANGE = 0x2

$winapi = Add-Type -MemberDefinition $signature -Name WinAPI -PassThru
[void]$winapi::SystemParametersInfo($SPI_SETMOUSESONAR, 0, 1, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)

}
function TurnItOff {
$signature = @'
[DllImport("user32.dll")]
public static extern bool SystemParametersInfo(
    uint uiAction,
    uint uiParam,
    uint pvParam,
    uint fWinIni);
'@

$SPI_SETMOUSESONAR = 0x101D
$SPIF_UPDATEINIFILE = 0x1
$SPIF_SENDCHANGE = 0x2

$winapi = Add-Type -MemberDefinition $signature -Name WinAPI -PassThru
[void]$winapi::SystemParametersInfo($SPI_SETMOUSESONAR, 0, 0, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)
}

function ActivateScript {
    TurnItOn
    echo "MouseSonar has been activated!"
    echo "To use the sonar, press `'CTRL`'"
    echo ""
    echo "Program terminating in 5 seconds..."
    Start-Sleep -s 5
    exit
}

function DeactivateScript {
    TurnItOff
    echo "MouseSonar has been disabled."
    echo "You will now notice It will not work."
    echo ""
    echo "Program terminating in 5 seconds..."
    Start-Sleep -s 5
    exit
}


function confirmScript {
    Get-PrintBright
    echo "What do you want to do`:"
    echo ""
    echo "Enter the number `"1`" to activate MouseSonar!"
    echo "Enter the number `"2`" to deactivate MouseSonar!"
    echo ""
    echo "Enter the number `"0`" to exit!"
    echo ""
    $choVar = Read-Host -Prompt ' >'

    if ($choVar -eq "") {
        Get-PrintRequired
    } else {
        if ($choVar -eq 0) {
            exit
        }
        if ($choVar -eq 1) {
            ActivateScript
        }
        if ($choVar -eq 2) {
            DeactivateScript
        }
}
clear
confirmScript
}
confirmScript