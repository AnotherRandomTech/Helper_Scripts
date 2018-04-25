<###
# Title: Powershell API Install Software Task.
# Date: 25/4/18
# Description: Pulls the software list from the API Server to install the specified software
# Trigger: External C# Service App running as Workstation Admin.
###>

<#
    Valid Type Values: 

    0 = Choco / Chocolatey package
    1 = MSI Package
    2 = EXE
    3 = Batch Script
    4 = Powershell Script
#>

$APIURL = "https://teachercontroller-auto-dev-webapi01.azurewebsites.net/api/DeploySoftware";

$APIResponse = Invoke-WebRequest -Uri $APIURL -UseBasicParsing | ConvertFrom-Json

foreach($source in $APIResponse){
    if($source.isEnabled -eq $True){
        #Run only if task is set to enabled.
        
        #Chocolatey Install
        if($source.type -eq 0){
            # Check if Chocolatey is Installed
            if((Test-Path "C:\ProgramData\chocolatey") -eq $False){
            # Run Chocolatey Install from the net.
            Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
            }
            
            $InstallArgs = "install " + $source.name + " --yes"
            Start-Process "choco.exe" -WorkingDirectory "C:\ProgramData\chocolatey" -ArgumentList $InstallArgs -NoNewWindow -Wait

            #TODO Add return value Error checking to make sure it actually installs...
        }

        #MSI Install
        if($source.type -eq 1){
            #Softwarte is a MSI Installer

            # Build the Args string for running the program.
            $InstallArgs = "/promptrestart /a " + $source.path + $source.args ## Adds Custom Args if required.

            Start-Process "msiexec" -ArgumentList  -NoNewWindow -Wait

            #TODO Add return value Error checking to make sure it actually installs...
        }


        ## Add more value types from Server list.
        else{
            #Nothing. invalid type value.
        }
    }
}