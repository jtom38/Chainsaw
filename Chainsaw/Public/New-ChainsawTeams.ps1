
function New-ChainsawTeams {
    param (
        [string[]] $Levels,
        [string] $URI,
        [string] $MessageTemplate,
        [string] $MessageTitle,

        [string] $JsonConfig,

        [hashtable] $HashConfig

    )
    
    Process{
        . "$($PSScriptRoot)\Classes\TemplateConverter.ps1"
        . "$($PSScriptRoot)\Classes\ChainsawTeams.ps1"

        if( [string]::IsNullOrEmpty($HashConfig.Values.URI) -eq $false -and
            [string]::IsNullOrEmpty($HashConfig.Values.MessageTemplate) -eq $false -and
            [string]::IsNullOrEmpty($HashConfig.Values.MessageTitle) -eq $false){
                return [ChainsawTeams]::new()
            }
    }
}