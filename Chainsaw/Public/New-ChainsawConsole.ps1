
function New-ChainsawConsole {
    param (
        [String] $MessageTemplate, 
        [String[]] $Levels,

        [string] $PathConfig
    )
    
    Process {

        if ( [System.String]::IsNullOrEmpty($PathConfig) -eq $false ){
            return [ChainsawConsole]::new($PathConfig)
        }
        elseif ( [System.String]::IsNullOrEmpty($MessageTemplate) -eq $false -and
            [System.String]::IsNullOrEmpty($Levels) -eq $false ) {
            return [ChainsawConsole]::new($MessageTemplate, $Levels)
        }
        else {
            return [ChainsawConsole]::new()
        }

    }

}