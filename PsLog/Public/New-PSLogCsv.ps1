
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
            return [PSLogCsv]::new($PathConfig)
        }
        elseif ( [System.String]::IsNullOrEmpty($LogPath) -eq $false -and 
             [System.String]::IsNullOrEmpty($MessageTemplate) -eq $false -and
             [System.String]::IsNullOrEmpty($Levels) -eq $false) {

            return [PSLogCsv]::new($LogPath, $MessageTemplate, $Levels)
        }
        else {
            return [PSLogCsv]::new()
        }

    }
}