#Set Computer Name
$PC = Read-Host "Input Computer to Shutdown"

Stop-Computer -ComputerName $PC -Force