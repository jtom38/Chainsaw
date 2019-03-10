

function Enable-ChainsawCsv {
    [cmdletbinding()]
    param (
        [string] $LogPath,
        [string[]] $Levels,
        [string] $MessageTemplate

        #[string] $JsonConfig

        [switch] $ExportJson,
        [switch] $Force

    )
    
    Process{

        if($ExportJson){
            $json ConvertTo-Json -InputObject $Script:Chainsaw.Csv

            if($Force){
                
            }
        }
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