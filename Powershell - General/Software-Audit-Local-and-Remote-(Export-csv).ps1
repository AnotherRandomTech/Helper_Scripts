$PC = Read-Host "Input Computer Name ('.' for local)"
if($PC -eq "."){$PC = $env:COMPUTERNAME}

Get-WmiObject -Class Win32_Product -ComputerName $PC | Export-Csv ".\$PC-Software_Audit.csv" -Force -NoClobber -NoTypeInformation