#Creates empty array for data input
$Export = @()

#gets current OU location and site details
$OU = Get-WmiObject -Namespace root\rsop\computer -Class RSOP_Session

#Get Computer List from AD - Change this to your own School OU Location to Query.
$Computers = Get-ADComputer -Filter "samaccountname -like '*'" -SearchBase "OU=Desktops,OU=School Managed,OU=Computers,OU=E<site-code-here>S01,OU=Schools,DC=indigo,DC=schools,DC=internal"

foreach($source in $Computers){
#Test Online State then do stuff
if((Test-Connection $source.DNSHostName -Count 1 -Quiet) -eq "True"){

$BIOS = Get-WmiObject win32_bios -ComputerName $source.DNSHostName  -ErrorAction SilentlyContinue
$OU = Get-WmiObject -Computername $source.DNSHostName -Namespace root\rsop\computer -Class RSOP_Session -ErrorAction SilentlyContinue
$PCDetails = Get-WmiObject Win32_ComputerSystem -Computername $source.DNSHostName -ErrorAction SilentlyContinue


#Create the Data Export

  $Data = New-Object -TypeName PSObject

  $Data | Add-Member -Type NoteProperty -Name "OU" -Value ($OU.SOM -replace ",OU=Schools,DC=indigo,DC=schools,DC=internal")
  $Data | Add-Member -Type NoteProperty -Name "Online" -Value ("Online")
  $Data | Add-Member -Type NoteProperty -Name "Name" -Value ($source.Name)
  $Data | Add-Member -Type NoteProperty -Name "Current Login" -Value ($PCDetails.UserName)


  $Data | Add-Member -Type NoteProperty -Name "Make/Model" -Value ($PCDetails.Manufacturer)
  $Data | Add-Member -Type NoteProperty -Name "Version" -Value ($PCDetails.Make)
  $Data | Add-Member -Type NoteProperty -Name "Serial" -Value ($BIOS.SerialNumber)

  $Export += $Data

}} 

$Export | Export-Csv -Path "Active-Network-PCs.csv" -NoClobber -NoTypeInformation -Force
