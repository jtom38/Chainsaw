
<#
.Synopsis
This lets you enable chainsaw to send to Microsoft Teams Webhooks.

.Description
This is a wrapper for PSTeams.

.Link
https://github.com/EvotecIT/PSTeams 
#>
function Enable-ChainsawTeams {
    param (
        [string] $URI,
        [string[]] $Levels,
        #[string] $MessageTemplate,
        [string] $MessageTitle,
        #[string] $Subtitle,

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