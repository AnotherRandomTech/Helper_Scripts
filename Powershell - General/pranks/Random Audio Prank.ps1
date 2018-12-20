<# Will Play an Audio File from a Directory in the background. Modified to 
Source: https://www.pdq.com/blog/powershell-music-remotely/
#>
## Fix Invoke-WebRequest Failing on all Requests
[Net.ServicePointManager]::SecurityProtocol = "Tls12, Tls11, tls"

$RandomChoice = Get-Random(0..9)
#Write-Host ("Choice :", $RandomChoice)
switch ($RandomChoice)
{
    0 { $URL = [uri]"https://raw.githubusercontent.com/AnotherRandomTech/Helper_Scripts/master/Powershell - General/pranks/audio/1 min to auto destruct.mp3" }
    1 { $URL = [uri]"https://raw.githubusercontent.com/AnotherRandomTech/Helper_Scripts/master/Powershell - General/pranks/audio/Authorization denied.mp3" }
    2 { $URL = [uri]"https://raw.githubusercontent.com/AnotherRandomTech/Helper_Scripts/master/Powershell - General/pranks/audio/Auto destruct armed.mp3" }
    3 { $URL = [uri]"https://raw.githubusercontent.com/AnotherRandomTech/Helper_Scripts/master/Powershell - General/pranks/audio/Eat_My_Photons_Small_Heads.mp3" } 
    4 { $URL = [uri]"https://raw.githubusercontent.com/AnotherRandomTech/Helper_Scripts/master/Powershell - General/pranks/audio/HAL_9000_Open_The_Pod_Bay_Doors.mp3" }
    5 { $URL = [uri]"https://raw.githubusercontent.com/AnotherRandomTech/Helper_Scripts/master/Powershell - General/pranks/audio/Ill Be Back.mp3" }
    6 { $URL = [uri]"https://raw.githubusercontent.com/AnotherRandomTech/Helper_Scripts/master/Powershell - General/pranks/audio/Somebody Stop Me.mp3" }
    7 { $URL = [uri]"https://raw.githubusercontent.com/AnotherRandomTech/Helper_Scripts/master/Powershell - General/pranks/audio/Rick Astley - Never Gonna Give You Up.mp3" }
    8 { $URL = [uri]"https://raw.githubusercontent.com/AnotherRandomTech/Helper_Scripts/master/Powershell - General/pranks/audio/Theres_something_on_your_face.mp3" }
    9 { $URL = [uri]"https://raw.githubusercontent.com/AnotherRandomTech/Helper_Scripts/master/Powershell - General/pranks/audio/Youre_fat_TomSka.mp3" }
}


try{
#Write-Host "Downloading..."
$outFile = ($env:APPDATA + "\prank_audio.mp3")
(New-Object System.Net.WebClient).DownloadFile($URL, $outFile)
}
catch{
Write-Error "Error downloading prank audio!"
exit -1
}

## Set Audio to 100%
Function Set-Speaker($Volume){
$wshShell = new-object -com wscript.shell;1..50 | % {$wshShell.SendKeys([char]174)};1..$Volume | % {$wshShell.SendKeys([char]175)}
}
Set-Speaker -Volume 50

Add-Type -AssemblyName presentationCore
try{
$wmplayer = New-Object System.Windows.Media.MediaPlayer
$wmplayer.Open($outFile)
Start-Sleep 2 # This allows the $wmplayer time to load the audio file
$duration = $wmplayer.NaturalDuration.TimeSpan.TotalSeconds

if($duration -eq $null){
Write-Error "Error playing audio!"
exit -2
}

$wmplayer.Play()
Start-Sleep $duration
$wmplayer.Stop()
$wmplayer.Close()

}
catch{
Write-Error "Error playing audio!"
exit -2
}

## Finish up and remove files.
Remove-Item $outFile | Out-Null
