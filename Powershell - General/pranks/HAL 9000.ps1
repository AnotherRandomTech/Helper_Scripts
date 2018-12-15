## HAL 9000 - Open the Pod Bay Doors
if ((Get-Random -Maximum 10000) -lt 1875) {
    Add-Type -AssemblyName System.Speech
    $SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $SpeechSynth.Speak("Open the pod bay doors, HAL")
    sleep 1
    $SpeechSynth.Speak("I'm sorry Dave. I'm afraid I can't do that.")
}