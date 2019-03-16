
<#
.Synopsis
This will allow you to enter values that are bound to the Microsoft Teams endpoint.

.Description
In order to send to Console you need to make sure you have the following paramerters filled.
[string[]]  $Levels
[string]    $MessageTemplate

.Parameter URI
[string] This will define the Webhook URL that we will send data to.

.Parameter Levels
[string[]] This will define the events that it will monitor for.  Enter the following values that are pre defined.
    "Emergency"
    "Alert"
    "Critical"
    "Error"
    "Warning"
    "Notice"
    "Information"
    "Debug"

.Parameter MessageTitle
[string] This will define the header message in Teams.
If you have several processes that use the same webhook you can use this to define the process name.

.Parameter ScopeGlobal
[switch] ScopeGlobal defines where to look for the Chainsaw Configuration.

.Parameter JsonConfig
[string] This if filled will tell it where to look for a exported config file to reimport.

.Example
Enable-ChainsawTeams -URI "https://FakeUrl.com" -Levels @("Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Information", "Debug") -MessageTitle 'Message From Chainsaw'
Enable-ChainsawTeams -JsonConfig '.\chainsaw.json'
#>
function Enable-ChainsawTeams {
    param (
        [string] $URI,
        [string[]] $Levels,
        [string] $MessageTitle,

        [switch] $ScopeGlobal,

        [string] $JsonConfig
    )
    
    if($ScopeGlobal -and [string]::IsNullOrEmpty($JsonConfig) -eq $false ){
        [bool] $found = Test-Path -Path $JsonConfig
        if ( $found -eq $true){
            $json = Get-Content -Path $JsonConfig | ConvertFrom-Json
            if([string]::IsNullOrEmpty($json.Teams.Levels) -eq $false) {
                $Global:Chainsaw.Teams.Levels = $json.Teams.Levels
            }
            if( [string]::IsNullOrEmpty($json.Teams.URI) -eq $false){
                $Global:Chainsaw.Teams.URI = $json.Teams.URI
            }
            if( [string]::IsNullOrEmpty($json.Teams.MessageTitle) -eq $false){
                $Global:Chainsaw.Teams.MessageTitle = $json.Teams.MessageTitle
            }
        }
    }

    # -JsonConfig "Path"
    elseif([string]::IsNullOrEmpty($JsonConfig) -eq $false){
        [bool] $found = Test-Path -Path $JsonConfig
        if ( $found -eq $true){
            $json = Get-Content -Path $JsonConfig | ConvertFrom-Json
            if([string]::IsNullOrEmpty($json.Teams.Levels) -eq $false) {
                $Script:Chainsaw.Teams.Levels = $json.Teams.Levels
            }
            if( [string]::IsNullOrEmpty($json.Teams.URI) -eq $false){
                $Script:Chainsaw.Teams.URI = $json.Teams.URI
            }
            if( [string]::IsNullOrEmpty($json.Teams.MessageTitle) -eq $false){
                $Script:Chainsaw.Teams.MessageTitle = $json.Teams.MessageTitle
            }
        }
    }

    # -ScopeGlobal *
    elseif($ScopeGlobal){
        if([string]::IsNullOrEmpty($Levels) -eq $false) {
            $Global:Chainsaw.Teams.Levels = $Levels
        }
        if( [string]::IsNullOrEmpty($URI) -eq $false){
            $Global:Chainsaw.Teams.URI = $URI
        }
        if( [string]::IsNullOrEmpty($MessageTitle) -eq $false){
            $Global:Chainsaw.Teams.MessageTitle = $MessageTitle
        }
    }

    else{
        if([string]::IsNullOrEmpty($Levels) -eq $false) {
            $Script:Chainsaw.Teams.Levels = $Levels
        }
        if( [string]::IsNullOrEmpty($URI) -eq $false){
            $Script:Chainsaw.Teams.URI = $URI
        }
        if( [string]::IsNullOrEmpty($MessageTitle) -eq $false){
            $Script:Chainsaw.Teams.MessageTitle = $MessageTitle
        }
    }
    
}