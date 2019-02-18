
function New-ChainsawEventLog {
    param (
        [string[]] $Levels, 
        [string] $LogName, 
        [string] $Source,

        [string] $PathConfig
    )

    Process {

        if ( [System.String]::IsNullOrEmpty($PathConfig) -eq $false ) {
            return [ChainsawEventLog]::new($PathConfig)
        }

    }
    
}