
# Region Import classes for PSv5+
using module .\PsLogCsv\Classes\ConsoleSettings.psm1
using module .\PsLogCsv\Classes\CsvSettings.psm1
using module .\PsLogCsv\Classes\PSLog.psm1
# End Region

Write-Debug -Message "Looking for all files in Public"
$Public =  @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)

Write-Debug -Message "Looking for all files in Private"
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

foreach($import in @($Public + $Private + $Classes)){

    try{
        . $import.fullname
    }catch{
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename
