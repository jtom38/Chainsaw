
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



    }
}