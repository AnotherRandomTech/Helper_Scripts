## What Does Trump Think API
if ((Get-Random -Maximum 10000) -lt 1875) {
    Add-Type -AssemblyName System.Speech
    $SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $Message = (ConvertFrom-Json (Invoke-WebRequest -Uri 'https://api.whatdoestrumpthink.com/api/v1/quotes/random' -UseBasicParsing)).message
    $SpeechSynth.Speak("Trump Thinks that..")
    $SpeechSynth.Speak($Message)
}