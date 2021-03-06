#Get Some Details
$BIOS = Get-WmiObject win32_bios -ComputerName $env:COMPUTERNAME  -ErrorAction SilentlyContinue
$OU = Get-WmiObject -Computername $env:COMPUTERNAME -Namespace root\rsop\computer -Class RSOP_Session -ErrorAction SilentlyContinue
$PCDetails = Get-WmiObject Win32_ComputerSystem -Computername $env:COMPUTERNAME -ErrorAction SilentlyContinue

#Format the Sites OU
$Top = ",OU=Schools,DC=indigo,DC=schools,DC=internal"
$Middle = "OU=" + $OU.Site

$OUPath = "," + "OU=Computers" + "," + $Middle + $Top

$Export = @()

#Online Test
if((Test-Connection "indigo.schools.internal" -Count 1 -Quiet) -eq "True"){$Online = "Online" }
else{$Online = "Error!" }


  $Data = New-Object -TypeName PSObject

  $Data | Add-Member -Type NoteProperty -Name "Network Online" -Value ($Online)
  $Data | Add-Member -Type NoteProperty -Name "Name" -Value ($env:COMPUTERNAME)  
  $Data | Add-Member -Type NoteProperty -Name "Current Login" -Value ($PCDetails.UserName)
  $Data | Add-Member -Type NoteProperty -Name "OU" -Value ($OU.SOM -replace $OUPath)

  $Data | Add-Member -Type NoteProperty -Name "Manufacturer" -Value ($PCDetails.Manufacturer)
  $Data | Add-Member -Type NoteProperty -Name "Make" -Value ($PCDetails.Model)
  $Data | Add-Member -Type NoteProperty -Name "Serial" -Value ($BIOS.SerialNumber)

  $Export += $Data

  $Export | Export-Csv -Path "Computer-Serials.csv" -NoTypeInformation -NoClobber -Append