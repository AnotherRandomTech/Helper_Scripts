#function Test-OnlineServers {
Write-Host "testing SSL Link first..." -ForegroundColor Green
if((Test-Connection -ComputerName 10.0.1.2 -Quiet) -eq $False){
Write-Host "SSL Link not up, stopping" -ForegroundColor Red
sleep 10
exit 0}

Write-Host "Importing Data..." -ForegroundColor Green
$Export = @()
$File = "D:\Shares\Shared$\500 PERSONAL\510 PROJECTS\511 CURRENT PROJECTS\ICT Dashboard - 2017\Online Services Test\Server-Ports.csv"
$InData = Import-Csv -Path $File -Encoding UTF8 -Delimiter ","

foreach($_ in $InData){

$Online = Test-NetConnection $_.IPAddress -Port $_.Port -ErrorAction SilentlyContinue -WarningAction SilentlyContinue | Select -ExpandProperty TcpTestSucceeded

$Data = New-Object -TypeName PSObject

  $Data | Add-Member -Type NoteProperty -Name "HostName" -Value ($_.HostName)
  $Data | Add-Member -Type NoteProperty -Name "IP Address" -Value ($_.IPAddress)
  $Data | Add-Member -Type NoteProperty -Name "Port" -Value ($_.Port)
  $Data | Add-Member -Type NoteProperty -Name "Online" -Value ($Online)
  $Data | Add-Member -Type NoteProperty -Name "Port Description" -Value ($_.PortDescription)

  $Export += $Data
  
}
$Export | Out-GridView
#}