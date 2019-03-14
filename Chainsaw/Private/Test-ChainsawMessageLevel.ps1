

function Test-ChainsawMessageLevel {
    [cmdletbinding()]
    param (
        [switch] $Console,
        [switch] $CSV,
        [switch] $EventLog,
        [switch] $Teams,

        [string] $Level
    )
    
    Process{
        if ($Console){
            [hashtable] $h = Get-ChainsawConfig -Console
            $EndpointLevels = $h.Levels
        }
        elseif ($CSV){
            [hashtable] $h = Get-ChainsawConfig -CSV
            $EndpointLevels = $h.Levels
        }
        elseif($EventLog){
            #$EndpointLevels = $Script:Chainsaw.EventLog.Levels
        }
        elseif($Teams){
            [hashtable] $h = Get-ChainsawConfig -Teams
            $EndpointLevels = $h.Levels
        }
        
        [bool] $LevelsCheck = $false

        foreach($i in $EndpointLevels){
            if ( $i -eq $Level) {
                return $true
            }
        }

        return $false
    }
}