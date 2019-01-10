<#
.Description
Due to how PowerShell handles classes this was built to take all the classes that I have in seperate files and merger them into one file.  
This way to import the lib you just call one file.

This is my building file.  Use this if you want to build a fresh class module if you made changes to the source.
#>

Write-Host "Building class file based off of .\PSLog\Classes"
# Define where the classes are and pull them into memory
$Files = Get-ChildItem -Path .\PSLog\Classes

# Define where the new Module file will be
$ClassModule = "$psscriptroot\PSLog\PSLogClasses.ps1"
if ( [System.IO.File]::Exists($ClassModule) -eq $true ) {
    # Delete the old one
    [System.IO.File]::Delete($ClassModule)
}

# Generate the new blank file
New-Item -Path ".\PSLog" -Name "PSLogClasses.ps1" | Out-Null

$dt = [datetime]::Now
Add-Content -Path $ClassModule -Value "# Generated $dt"
# Loop though each file and take the content and place it in the new file
foreach ( $f in $Files) {

    $raw = Get-Content $f.FullName

    Add-Content -Path $ClassModule -Value $raw
    
}

# Run to preloader
Import-Module .\PsLog\PsLog.psm1
. .\PsLog\PSLogClasses.ps1 -Force
#. .\PsLog\ImportLib.ps1

# Run the unit tests on the new build
Write-Host "Starting Unit Testing"
.\Run-UnitTests.ps1