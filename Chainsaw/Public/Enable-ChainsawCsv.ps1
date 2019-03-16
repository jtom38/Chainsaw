
<#
.Synopsis
This will allow you to enter values that bound to the CSV endpoint.

.Description
In order to send to CSV, you need to make sure you have the following parameters filled.
[string]    $LogPath
[string[]]  $Levels
[string]    $MessageTemplate

.Parameter LogPath
[string] LogPath defines the location where the CSV entries will be written to.

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
Enable-ChainsawCsv -LogPath '.\log.csv' -Levels @("Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Information", "Debug") -MessageTemplate "#DateTime#, #Level#, #CallingFile#, #ErrorCode#, #LineNumber#, #Message#"
Enable-ChainsawCsv -JsonPath '.\chainsaw.json'
#>
function Enable-ChainsawCsv {
    [cmdletbinding()]
    param (
        [string] $LogPath,
        [string[]] $Levels,
        [string] $MessageTemplate,

        [switch] $ScopeGlobal,

        [string] $JsonConfig

    )
    
    Process{

        # -ScopeGlobal -JsonConfig "path"
        if ($ScopeGlobal -and [string]::IsNullOrEmpty($JsonConfig) -eq $false){
            [bool] $found = Test-Path -Path $JsonConfig
            if ( $found -eq $true){
                $json = Get-Content -Path $JsonConfig | ConvertFrom-Json
                if([string]::IsNullOrEmpty($json.CSV.Levels) -eq $false) {
                    $Global:Chainsaw.CSV.Levels = $json.CSV.Levels
                }
                if([string]::IsNullOrEmpty($json.CSV.MessageTemplate) -eq $false) {
                    $Global:Chainsaw.CSV.MessageTemplate = $json.CSV.MessageTemplate
                }
                if( [string]::IsNullOrEmpty($json.CSV.LogPath) -eq $false){
                    $Global:Chainsaw.CSV.LogPath = $json.CSV.LogPath
                }
            }
        }

        # -JsonConfig "Path"
        elseif([string]::IsNullOrEmpty($JsonConfig) -eq $false){
            [bool] $found = Test-Path -Path $JsonConfig
            if ( $found -eq $true){
                $json = Get-Content -Path $JsonConfig | ConvertFrom-Json
                if([string]::IsNullOrEmpty($json.CSV.Levels) -eq $false) {
                    $Script:Chainsaw.CSV.Levels = $json.CSV.Levels
                }
                if([string]::IsNullOrEmpty($json.CSV.MessageTemplate) -eq $false) {
                    $Script:Chainsaw.CSV.MessageTemplate = $json.CSV.MessageTemplate
                }
                if( [string]::IsNullOrEmpty($json.CSV.LogPath) -eq $false){
                    $Script:Chainsaw.CSV.LogPath = $json.CSV.LogPath
                }
            }
        }
        # -ScopeGlobal *
        elseif($ScopeGlobal){
            if([string]::IsNullOrEmpty($Levels) -eq $false) {
                $Global:Chainsaw.CSV.Levels = $Levels
            }
            if([string]::IsNullOrEmpty($MessageTemplate) -eq $false) {
                $Global:Chainsaw.CSV.MessageTemplate = $MessageTemplate
            }
            if( [string]::IsNullOrEmpty($LogPath) -eq $false){
                $Global:Chainsaw.CSV.LogPath = $LogPath
            }
        }

        # -Levels -MessageTemplate -LogPath
        else{
            if([string]::IsNullOrEmpty($Levels) -eq $false) {
                $Script:Chainsaw.CSV.Levels = $Levels
            }
            if([string]::IsNullOrEmpty($MessageTemplate) -eq $false) {
                $Script:Chainsaw.CSV.MessageTemplate = $MessageTemplate
            }
            if( [string]::IsNullOrEmpty($LogPath) -eq $false){
                $Script:Chainsaw.CSV.LogPath = $LogPath
            }
        }

    }
}