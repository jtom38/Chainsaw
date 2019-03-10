

function Enable-ChainsawCsv {
    [cmdletbinding()]
    param (
        [string] $LogPath,
        [string[]] $Levels,
        [string] $MessageTemplate

        #[string] $JsonConfig
    )
    
    Process{
        if( [string]::IsNullOrEmpty($Levels) -eq $false) {
            $Script:Chainsaw.CSV.Levels = $Levels
        }
        
        if( [string]::IsNullOrEmpty($MessageTemplate) -eq $false){
            $Script:Chainsaw.CSV.MessageTemplate = $MessageTemplate
        }

        if( [string]::IsNullOrEmpty($LogPath) -eq $false){
            $Script:Chainsaw.CSV.LogPath = $LogPath
        }
    }
}