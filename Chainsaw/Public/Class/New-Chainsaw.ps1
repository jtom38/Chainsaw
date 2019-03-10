
<#
.Synopsis
Returns 
#>
function New-Chainsaw {
    param(
        # Loads the dev classes into memory
        [switch] $Dev
    )
    . "$($PSScriptRoot)\Classes\TemplateConverter.ps1"
    . "$($PSScriptRoot)\Classes\Chainsaw.ps1"
    . "$($PSScriptRoot)\Classes\ChainsawConsole.ps1"
    . "$($PSScriptRoot)\Classes\ChainsawCsv.ps1"
    . "$($PSScriptRoot)\Classes\ChainsawEventLog.ps1"
    . "$($PSScriptRoot)\Classes\ChainsawTeams.ps1"

    return [Chainsaw]::new()
    
}