
<#
.Synopsis
Generates a new ChainsawConsole class.

.Description
This will generate a new ChainsawConsole class and handle the constructor for you.
Look at the examples for how to deal with the constructors.


.Example
New-ChainsawConsole -MessageTemplate "[#DateTime#] [#Level#] #Message#" -Levels @("Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Information", "Debug")
New-ChainsawConsole -PathConfig .\config.json
New-ChainsawConsole -HashConfig $ConsoleConfig

.Outputs
ChainsawConsole
#>
function New-ChainsawConsole {
    [cmdletbinding()]
    param (
        # Standard filling of the variables
        [String] $MessageTemplate, 
        [String[]] $Levels,

        # Load the config in from a json
        [string] $PathConfig,

        # Load the config from a hashtable.
        # New-ChainsawConfig -Console
        [hashtable] $HashConfig
    )
    
    Process {

        # Load from HashTable
        if ([System.String]::IsNullOrEmpty($HashConfig.Levels) -eq $false -and
            [System.String]::IsNullOrEmpty($HashConfig.$MessageTemplate) -eq $false){
                return [ChainsawConsole]::new($HashConfig.$MessageTemplate, $HashConfig.Levels)
        }

        # Load from JSON
        if ( [System.String]::IsNullOrEmpty($PathConfig) -eq $false ){
            return [ChainsawConsole]::new($PathConfig)
        }

        # Manual process
        if ( [System.String]::IsNullOrEmpty($MessageTemplate) -eq $false -and
            [System.String]::IsNullOrEmpty($Levels) -eq $false ) {
            return [ChainsawConsole]::new($MessageTemplate, $Levels)
        }
        
        # Load a blank constructor
        return [ChainsawConsole]::new()

    }

}