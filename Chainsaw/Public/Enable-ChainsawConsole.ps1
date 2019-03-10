

function Enable-ChainsawConsole {
    [cmdletbinding()]
    param (
        [string[]] $Levels,
        [string] $MessageTemplate,

        [string] $JsonConfig,

        [switch] $ScopeGlobal
    )

    Process{

        if($ScopeGlobal){
            if( [string]::IsNullOrEmpty($Levels) -eq $false) {
                $Global:Chainsaw.Console.Levels = $Levels
            }
            
            if( [string]::IsNullOrEmpty($MessageTemplate) -eq $false){
                $Global:Chainsaw.Console.MessageTemplate = $MessageTemplate
            }
        }
        else{
            if( [string]::IsNullOrEmpty($Levels) -eq $false) {
                $Script:Chainsaw.Console.Levels = $Levels
            }
            
            if( [string]::IsNullOrEmpty($MessageTemplate) -eq $false){
                $Script:Chainsaw.Console.MessageTemplate = $MessageTemplate
            }
        }


    }
}