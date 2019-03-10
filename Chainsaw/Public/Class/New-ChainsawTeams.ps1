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
        if( [string]::IsNullOrEmpty($HashConfig.URI) -eq $false -and
            [string]::IsNullOrEmpty($HashConfig.MessageTemplate) -eq $false -and
            [string]::IsNullOrEmpty($HashConfig.MessageTitle) -eq $false -and 
            [string]::IsNullOrEmpty($HashConfig.Levels) -eq $false) {
                return [ChainsawTeams]::new(
                    $HashConfig.URI,
                    $HashConfig.MessageTemplate,
                    $HashConfig.MessageTitle,
                    $HashConfig.Levels
                )
        }
        elseif( [string]::IsNullOrEmpty($JsonConfig) -eq $false ){
            return [ChainsawTeams]::new($JsonConfig)
        }
        elseif( [string]::IsNullOrEmpty($Levels) -eq $false -and
            [string]::IsNullOrEmpty($URI) -eq $false -and
            [string]::IsNullOrEmpty($MessageTemplate) -eq $false -and
            [string]::IsNullOrEmpty($MessageTitle) -eq $false ){
                return [ChainsawTeams]::new(
                    $URI,
                    $MessageTemplate,
                    $MessageTitle,
                    $Levels
                )
        }
        else{
            return [ChainsawTeams]::new()
        }
    }
}