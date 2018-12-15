## Cat Facts API
if ((Get-Random -Maximum 10000) -lt 1875) {
    Add-Type -AssemblyName System.Speech
    $SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $Message = (ConvertFrom-Json (Invoke-WebRequest -Uri 'https://cat-fact.herokuapp.com/facts/random' -UseBasicParsing)).text
    $SpeechSynth.Speak($Message)
}
