
[cmdletbinding()]
param()

# Region Import classes for PSv5+
<#
Write-Verbose 'Import Classes in order because of dependencies'
$classList = @(
    'ConsoleSettings',
    'CsvSettings',
    'PsLog'
)

foreach($class in $classList)
{
    Write-host " Class: $class"
    Write-Host "$psscriptroot\Classes\$class.ps1"
    . "$psscriptroot\Classes\$class.ps1"
}
#>

. "$psscriptroot\Classes\ConsoleSettings.ps1"
. "$psscriptroot\Classes\CsvSettings.ps1"
. "$psscriptroot\Classes\PsLog.ps1"
# End Region

Write-Debug -Message "Looking for all files in Public"
$Public =  @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)

Write-Debug -Message "Looking for all files in Private"
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

foreach($import in @($Public + $Private)){

    try{
        . $import.fullname
    }catch{
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename
