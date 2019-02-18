#Requires -Version 5.0
[cmdletbinding()]
param()

[Reflection.Assembly]::LoadFile("$PSScriptRoot\Lib\MimeKit.dll")
[Reflection.Assembly]::LoadFile("$PSScriptRoot\Lib\MailKit.dll")

# Import General functions 

Write-Debug -Message "Looking for all files in Public"
$Public =  @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)

Write-Debug -Message "Looking for all files in Private"
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

# Import-ChainsawClasses exists at PSScriptRoot because of path issues

$class = "$PSScriptRoot\Import-ChainsawClasses.ps1"
$importClasses = Get-ChildItem -Path $class -ErrorAction SilentlyContinue
. $class

foreach($import in @($Public + $Private)){

    try{
        . $import.fullname
    }catch{
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename
Export-ModuleMember -Function $importClasses.Basename