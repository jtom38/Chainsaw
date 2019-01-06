
function New-PSLogCsv {
    [cmdletbinding()]
    param (
        [string] $LogPath, 
        [string] $MessageTemplate, 
        [string[]] $Levels,

        [string] $PathConfig
    )
    
    Process {
        
        if ( [System.String]::IsNullOrEmpty($PathConfig) -eq $false ) {
            # If we get the config path we will use that first
            return New-PSLogConfig -PathConfig $PathConfig
        }

        if ( [System.String]::IsNullOrEmpty($LogPath) -eq $false -and 
             [System.String]::IsNullOrEmpty($MessageTemplate) -eq $false -and
             [System.String]::IsNullOrEmpty($Levels) -eq $false) {

            return New-PSLogCsvParam -LogPath $LogPath -MessageTemplate $MessageTemplate -Levels $Levels
        }

    }
}