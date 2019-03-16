
<#
.Synopsis
This will allow you to enter values that are bound to the Console endpoint.

.Description
In order to send to Console, you need to make sure you have the following parameters filled.
[string[]]  $Levels
[string]    $MessageTemplate

.Parameter Levels
[string[]] This will define the events that it will monitor for.  Enter the following values that are predefined.
    "Emergency"
    "Alert"
    "Critical"
    "Error"
    "Warning"
    "Notice"
    "Information"
    "Debug"

.Parameter MessageTemplate
[string] This defines the format of the message that will be displayed in.  Use any of the following values in a string to build the MessageTemplate.
    #DateTime#
    #Level#
    #CallingFile#
    #ErrorCode#
    #LineNumber#
    #Message#

.Parameter ScopeGlobal
[switch] ScopeGlobal defines where to look for the Chainsaw Configuration.

.Parameter JsonConfig
[string] This if filled will tell it where to look for an exported config file to reimport.

.Example

Enable-ChainsawConsole -Levels @("Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Information", "Debug") -MessageTemplate '#DateTime# #Level# #Message#'
Enable-ChainsawConsole -JsonConfig '.\chainsaw.json'
#>
function Enable-ChainsawConsole {
    #[cmdletbinding()]
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