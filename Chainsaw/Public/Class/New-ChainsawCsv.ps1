
function New-ChainsawCsv {
    [cmdletbinding()]
    param (
        [string] $LogPath, 
        [string] $MessageTemplate, 
        [string[]] $Levels,

        [string] $PathConfig,

        [hashtable] $HashConfig
    )
    
    Process {
        . "$($PSScriptRoot)\Classes\TemplateConverter.ps1"
        . "$($PSScriptRoot)\Classes\ChainsawCsv.ps1"

        if( [string]::IsNullOrEmpty($HashConfig.Values.LogPath) -eq $false -and 
            [string]::IsNullOrEmpty($HashConfig.Values.MessageTemplate) -eq $false -and
            [string]::IsNullOrEmpty($HashConfig.Values.Levels) -eq $false ){
                return [ChainsawCsv]::new(
                    $HashConfig.Values.LogPath,
                    $HashConfig.Values.MessageTemplate,
                    $HashConfig.Values.Levels)
        }
        elseif ( [System.String]::IsNullOrEmpty($PathConfig) -eq $false ) {
            # If we get the config path we will use that first
            return [ChainsawCsv]::new($PathConfig)
        }
        elseif ( [System.String]::IsNullOrEmpty($LogPath) -eq $false -and 
             [System.String]::IsNullOrEmpty($MessageTemplate) -eq $false -and
             [System.String]::IsNullOrEmpty($Levels) -eq $false) {

            return [ChainsawCsv]::new($LogPath, $MessageTemplate, $Levels)
        }
        else {
            return [ChainsawCsv]::new()
        }

    }
}
