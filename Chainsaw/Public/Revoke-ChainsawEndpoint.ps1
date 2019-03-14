
<#
.Synopsis
This will force the removal of values stored for the selected endpoint.

.Parameter Console
[switch] This will clear out Console variables.

.Parameter CSV
[switch] THis will clear out CSV variables.

.Parameter Force
[switch] This is required if you want to flush the variables out of memory.
#>

function Revoke-ChainsawEndpoint {
    param (
        [switch] $Console,
        [switch] $CSV,
        [switch] $Force
    )

    if($Force){

        if($Console){
            $Script:Chainsaw.Console.Levels = @()
            $Script:Chainsaw.Console.MessageTemplate = ''
    
            $Global:Chainsaw.CSV.Levels = @()
            $Global:Chainsaw.CSV.MessageTemplate = ''
        }

        if($CSV){
            $Script:Chainsaw.CSV.Levels = @()
            $Script:Chainsaw.CSV.MessageTemplate = ''
            $Script:Chainsaw.CSV.LogPath = ''
    
            $Global:Chainsaw.CSV.Levels = @()
            $Global:Chainsaw.CSV.MessageTemplate = ''
            $Global:Chainsaw.CSV.LogPath = ''
        }
    }else{
        throw "Request to revoke CSV Endpoint failed.  It is required to use -Force as a safe guard"
    }
    
}