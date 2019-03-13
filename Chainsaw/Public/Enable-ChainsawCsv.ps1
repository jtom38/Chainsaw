

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