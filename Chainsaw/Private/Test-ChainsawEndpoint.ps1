
<#
.SYNOPSIS
This will run tests against the endpoints to see if it is valid to send messages too.
#>
function Test-ChainsawEndpoint {
    [cmdletbinding()]
    param (
        [switch] $Console,
        [switch] $CSV,
        [switch] $EventLog,
        [switch] $Teams
    )
    
    Process {
        # Check the required variables
        if($Console){

            $t = Get-ChainsawConfig -Console
            if( [string]::IsNullOrEmpty($t.MessageTemplate) -eq $false){
                return $true
            }
            return $false
        }

        if($CSV){
            $t = Get-ChainsawConfig -CSV
            if( [string]::IsNullOrEmpty($t.LogPath) -eq $false -and
                [string]::IsNullOrEmpty($t.MessageTemplate) -eq $false ){
                    return $true
            }
            return $false
        }

        if($Teams){
            $t = Get-ChainsawConfig -Teams
            if( [string]::IsNullOrEmpty($t.URI) -eq $false -and
                [string]::IsNullOrEmpty($t.MessageTitle) -eq $false){
                    return $true
            }
            return $false
        }
    }
}