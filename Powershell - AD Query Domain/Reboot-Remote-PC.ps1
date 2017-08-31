#Set Computer Name
$PC = Read-Host "Input Computer to Shutdown"

Restart-Computer -ComputerName $PC -Force