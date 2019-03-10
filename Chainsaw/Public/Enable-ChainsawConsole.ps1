

function Enable-ChainsawConsole {
    [cmdletbinding()]
    param (
        [string[]] $Levels,
        [string] $MessageTemplate,

        [string] $JsonConfig
    )

    Process{

        if( [string]::IsNullOrEmpty($Levels) -eq $false) {
            $Script:Chainsaw.Console.Levels = $Levels
        }
        
        if( [string]::IsNullOrEmpty($MessageTemplate) -eq $false){
            $Script:Chainsaw.Console.MessageTemplate = $MessageTemplate
        }
    }
}