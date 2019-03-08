<#
.Synopsis
Returns you a new [ChainsawTeams] variable

.Example
New-ChainsawTeams -JsonConfig ".\config.json"

.Example
$HashConfig = New-ChainsawConfig -Teams
New-ChainsawTeams -HashConfig $HashConfig

.Example
New-ChainsawTeams -Levels 
#>
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

        $HashConfig.Levels
        if( [string]::IsNullOrEmpty($HashConfig.URI.Value) -eq $false -and
            [string]::IsNullOrEmpty($HashConfig.MessageTemplate.Value) -eq $false -and
            [string]::IsNullOrEmpty($HashConfig.MessageTitle.Value) -eq $false -and 
            [string]::IsNullOrEmpty($HashConfig.Levels.Value) -eq $false) {
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