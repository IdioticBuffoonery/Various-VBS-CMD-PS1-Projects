## Open the background song
$script = @'
   $player = New-Object -ComObject 'MediaPlayer.MediaPlayer'
   $player.Open("http://www.leeholmes.com/projects/ps_html5/background.mp3")
   $player
'@

## ... in a background MTA-threaded PowerShell because
## the MediaPlayer COM object doesn't like STA
## $runspace = [RunspaceFactory]::CreateRunspace()
## $runspace.ApartmentState = "MTA"
$bgPowerShell = [PowerShell]::Create()
$bgPowerShell.Runspace = $runspace
## $runspace.Open()
$player = @($bgPowerShell.AddScript($script).Invoke())[0]
echo "
 .______       __    ______  __  ___ .______        ______    __       __       _______  _______  
 |   _  \     |  |  /      ||  |/  / |   _  \      /  __  \  |  |     |  |     |   ____||       \ 
 |  |_)  |    |  | |  ,----'|  '  /  |  |_)  |    |  |  |  | |  |     |  |     |  |__   |  .--.  |
 |      /     |  | |  |     |    <   |      /     |  |  |  | |  |     |  |     |   __|  |  |  |  |
 |  |\  \----.|  | |  `----.|  .   \  |  |\  \----.|   `--'  | |   `----.|  `----. |  |____ |  '--'  |
 | _| `.______||__|  \______||__|\__\ | _| `._____|  \______/  |_______||_______||_______||_______/ 


	Lyrics to 'Never Gonna Give You Up by Rick Astley'
		  Brought to you by @HBIDamian                                                                     
"                                                                                         
Start-Sleep -s 19
echo "	We're no strangers to love"
Start-Sleep -s 4
echo "	You know the rules and so do I"
Start-Sleep -s 4
echo "	A full commitment's what I'm thinking of"
Start-Sleep -s 5
echo "	You wouldn't get this from any other guy
"
Start-Sleep -s 4
echo "	I just want to tell you how I'm feeling"
Start-Sleep -s 4
echo "	Gotta make you understand
"
Start-Sleep -s 4
echo "	Never gonna give you up"
Start-Sleep -s 2	
echo "	Never gonna let you down"
Start-Sleep -s 2
echo "	Never gonna run around and desert you"
Start-Sleep -s 4
echo "	Never gonna make you cry"
Start-Sleep -s 2
echo "	Never gonna say goodbye"
Start-Sleep -s 2
echo "	Never gonna tell a lie and hurt you"
Start-Sleep -s 5