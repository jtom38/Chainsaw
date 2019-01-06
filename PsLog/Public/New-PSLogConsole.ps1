
function New-PSLogConsole {
    param (
        [String] $MessageTemplate, 
        [String[]] $Levels,

        [string] $PathConfig
    )
    
    Process {

        if ( [System.String]::IsNullOrEmpty($PathConfig) -eq $false ){
            return [PSLogConsole]::new($PathConfig)
        }
        elseif ( [System.String]::IsNullOrEmpty($MessageTemplate) -eq $false -and
            [System.String]::IsNullOrEmpty($Levels) -eq $false ) {
            return [PSLogConsole]::new($MessageTemplate, $Levels)
        }
        else {
            return [PSLogConsole]::new()
        }

    }

}