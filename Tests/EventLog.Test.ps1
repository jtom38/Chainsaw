
function New-PSLogEventLog {
    param (
        [string[]] $Levels, 
        [string] $LogName, 
        [string] $Source,

        [string] $PathConfig
    )

    Process {

        if ( [System.String]::IsNullOrEmpty($PathConfig) -eq $false ) {
            return [PSLogEventLog]::new($PathConfig)
        }

    }
    
}