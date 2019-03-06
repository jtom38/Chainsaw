
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
            [string]::IsNullOrEmpty($HashConfig.Values.MessageTitle) -eq $false -and 
            [string]::IsNullOrEmpty($HashConfig.Values.Levels) -eq $false) {
                return [ChainsawTeams]::new()
        }
        elseif( [string]::IsNullOrEmpty($JsonConfig) -eq $false ){
            return [ChainsawTeams]::new($JsonConfig)
        }
        elseif( [string]::IsNullOrEmpty($Levels) -eq $false -and
            [string]::IsNullOrEmpty($URI) -eq $false -and
            [string]::IsNullOrEmpty($MessageTemplate) -eq $false -and
            [string]::IsNullOrEmpty($MessageTitle) -eq $false ){
                return [ChainsawTeams]::new()
        }
        else{
            return [ChainsawTeams]::new()
        }
    }
}