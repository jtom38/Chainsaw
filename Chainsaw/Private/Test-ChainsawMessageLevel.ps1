

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
            $EndpointLevels = $Script:Chainsaw.Console.Levels
        }
        elseif ($CSV){
            $EndpointLevels = $Script:Chainsaw.CSV.Levels
        }
        elseif($EventLog){
            $EndpointLevels = $Script:Chainsaw.EventLog.Levels
        }
        elseif($Teams){
            $EndpointLevels = $Script:Chainsaw.Teams.Levels
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