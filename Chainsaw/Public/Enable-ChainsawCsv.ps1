

function Enable-ChainsawCsv {
    [cmdletbinding()]
    param (
        [string] $LogPath,
        [string[]] $Levels,
        [string] $MessageTemplate,

        [switch] $ScopeGlobal

        #[string] $JsonConfig

    )
    
    Process{

        if ($ScopeGlobal){
            if([string]::IsNullOrEmpty($Levels) -eq $false) {
                $Global:Chainsaw.CSV.Levels = $Levels
            }
            if([string]::IsNullOrEmpty($MessageTemplate) -eq $false) {
                $Global:Chainsaw.CSV.MessageTemplate = $MessageTemplate
            }
            if( [string]::IsNullOrEmpty($LogPath) -eq $false){
                $Global:Chainsaw.CSV.LogPath = $LogPath
            }
        }else{
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