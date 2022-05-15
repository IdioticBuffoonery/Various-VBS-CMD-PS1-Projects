# This is a proof of concept to enable Dev Tools in Discord
# Usage of this may break Discord's ToS, so use it at your own risk.
# This tool is not guaranteed to work.
# I hold no responsibility for any damage caused by this tool.
# Discord may push an update that breaks this tool, or the client.
# If the Discord client breaks, you may want to reinstall it, and try this tool again.
# If there is any issue, feel free to pull/fork this and fix it, or report it to me.
# This tool is not affiliated with Discord, Inc.

$host.ui.RawUI.WindowTitle = "Enable Dev Tools for Discord Stable Channel";
$global:7ZipLocation = "C:\Program Files\7-Zip";
$global:discord_desktop_coreLocation = "C:\Users\$env:UserName\AppData\Local\Discord\app-1.0.9004\modules\discord_desktop_core-3\discord_desktop_core";
function runHeader {
    clear-host
    Write-Host $host.ui.RawUI.WindowTitle -foreground "Cyan"
    Write-Host "This tool enables DevTools/Inspect Element on Discord's Stable Channel" -foreground "Cyan"
    Write-Host "This may break Discord's ToS." -foreground "DarkRed"
    Read-Host -Prompt "Press Enter to continue, or press Ctrl+C to exit"
    preChecks
}
function preChecks {
    if (!(Test-Path "$global:discord_desktop_coreLocation\core.asar")) {
        Write-Host "`r`nDiscord is not installed on this machine." -foreground "DarkRed"
        Write-Host "Please install Discord and try again." -foreground "DarkRed"
        Read-Host -Prompt "Press Enter to exit"
        exit
    } elseif (!(Test-Path "$global:7ZipLocation\7z.exe")) {
        Write-Host "`r`n7-Zip is not installed on this machine." -foreground "DarkRed"
        Write-Host "Please install 7-Zip and try again." -foreground "DarkRed"
        Read-Host -Prompt "Press Enter to exit"
        exit
    } elseif (!(Test-Path "$global:7ZipLocation\Formats\Asar.64.dll")) {
        Write-Host "`r`nAsar.64.dll is not installed in the 7-Zip/Formats directory." -foreground "DarkRed"
        Write-Host "Please install the extension via: https://www.tc4shell.com/en/7zip/asar/" -foreground "DarkRed"
        Read-Host -Prompt "Press Enter to exit"
        exit
    } elseif (Test-Path "$global:discord_desktop_coreLocation\core\") {
        Write-Host "`r`n$global:discord_desktop_coreLocation\core\ already exists.`r`nYou may want to delete the folder before you try again!" -foreground "DarkRed"
        Read-Host -Prompt "Press any key to exit"
        exit
    } else {
        Write-Host "`r`nWe're all set to go!" -foreground "DarkGreen"
        Write-Host "This is your last chance to back out!" -foreground "DarkRed"
        Read-Host -Prompt "Press Enter to continue enabling DevTools, or press Ctrl+C to exit"
        enableDevTools
    }
    exit
}
function enableDevTools {
    Write-Host "`r`nEnabling DevTools..." -foreground "Yellow"
    Write-Host "Killing Discord..." -foreground "Yellow"
    $discord = Get-Process discord -ErrorAction SilentlyContinue
    $discord | Stop-Process -Force
    if (Test-Path "$global:discord_desktop_coreLocation\core.asar") {
        Write-Host "Extracting $global:discord_desktop_coreLocation\core.asar..." -foreground "Yellow"
        & $global:7ZipLocation\7z.exe x $global:discord_desktop_coreLocation\core.asar "-o$global:discord_desktop_coreLocation\core" | Out-Null
    }
    if (Test-Path "$global:discord_desktop_coreLocation\index.js") {
        Write-Host "Replacing $global:discord_desktop_coreLocation\index.js..." -foreground "Yellow"
        Remove-Item -Path "$global:discord_desktop_coreLocation\index.js" -Force
        "module.exports = require('./core/app/index.js');" | Out-File -FilePath "$global:discord_desktop_coreLocation\index.js" -Encoding UTF8
    }
    if (Test-Path "$global:discord_desktop_coreLocation\core\app\index.js") {
        Write-Host "Replacing $global:discord_desktop_coreLocation\core\app\index.js..." -foreground "Yellow"
        $find = "const enableDevtools = buildInfo.releaseChannel === 'stable' ? enableDevtoolsSetting : true;";
        $replace = "const enableDevtools = buildInfo.releaseChannel === 'canary' ? enableDevtoolsSetting : true;";
        (Get-Content "$global:discord_desktop_coreLocation\core\app\index.js").replace($find, $replace) | Set-Content "$global:discord_desktop_coreLocation\core\app\index.js"
    }
    if (Test-Path "$global:discord_desktop_coreLocation\core\app\mainScreen.js") {
        Write-Host "Replacing $global:discord_desktop_coreLocation\core\app\mainScreen.js..." -foreground "Yellow"
        $find = "const ENABLE_DEVTOOLS = _buildInfo.default.releaseChannel === 'stable' ? settings.get('DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING', false) : true;";
        $replace = "const ENABLE_DEVTOOLS = _buildInfo.default.releaseChannel === 'canary' ? settings.get('DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING', false) : true;";
        (Get-Content "$global:discord_desktop_coreLocation\core\app\mainScreen.js").replace($find, $replace) | Set-Content "$global:discord_desktop_coreLocation\core\app\mainScreen.js"
    }
    Write-Host "DevTools has been enabled!" -foreground "Green"
    Read-Host -Prompt "Press any key to exit"
}
runHeader
