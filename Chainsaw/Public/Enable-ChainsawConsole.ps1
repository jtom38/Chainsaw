

function Enable-ChainsawConsole {
    [cmdletbinding()]
    param (
        [string[]] $Levels,
        [string] $MessageTemplate,

        [switch] $ScopeGlobal,

        [string] $JsonConfig
    )

    Process{

        # -ScopeGlobal -JsonConfig 'Path'
        if($ScopeGlobal -and [string]::IsNullOrEmpty($JsonConfig) -eq $false){
            [bool] $found = Test-Path -Path $JsonConfig
            if($found -eq $true){
                $json = Get-Content -Path $JsonConfig | ConvertFrom-Json

                if ( [string]::IsNullOrEmpty($json.Console.Levels) -eq $false){
                    $Global:Chainsaw.Console.Levels = $json.Console.Levels
                }

                if ( [string]::IsNullOrEmpty($json.Console.MessageTemplate)-eq $false){
                    $Global:Chainsaw.Console.MessageTemplate = $json.Console.MessageTemplate
                }
            } 
        }

        # -JsonConfig 'Path'
        elseif([string]::IsNullOrEmpty($JsonConfig) -eq $false){
            [bool] $found = Test-Path -Path $JsonConfig
            if($found -eq $true){
                $json = Get-Content -Path $JsonConfig | ConvertFrom-Json

                if ( [string]::IsNullOrEmpty($json.Console.Levels) -eq $false){
                    $Script:Chainsaw.Console.Levels = $json.Console.Levels
                }

                if ( [string]::IsNullOrEmpty($json.Console.MessageTemplate)-eq $false){
                    $Script:Chainsaw.Console.MessageTemplate = $json.Console.MessageTemplate
                }
            } 
        }

        # -ScopeGlobal
        elseif($ScopeGlobal){
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