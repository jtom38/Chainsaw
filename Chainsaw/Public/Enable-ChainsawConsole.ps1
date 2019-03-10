

function Enable-ChainsawConsole {
    [cmdletbinding()]
    param (
        [string[]] $Levels,
        [string] $MessageTemplate,

        [string] $JsonConfig,

        [switch] $ScopeGlobal,

        # used to clean out existing configs
        [switch] $Force
    )

    Process{

        # Check if we are going to store in the Global Scope
        if($ScopeGlobal){

            # Check if we have a config file to parse
            if ( [string]::IsNullOrEmpty($JsonConfig) -eq $false){
                $json = Get-Content -Path $JsonConfig | ConvertFrom-Json

                if ( [string]::IsNullOrEmpty($json.Console.Levels) -eq $false){
                    $Global:Chainsaw.Console.Levels = $json.Console.Levels
                }

                if ( [string]::IsNullOrEmpty($json.Console.MessageTemplate)-eq $false){
                    $Global:Chainsaw.Console.MessageTemplate = $json.Console.MessageTemplate
                }
            }

            # No Json was found, checking for manual load
            else{
                if( [string]::IsNullOrEmpty($Levels) -eq $false) {
                    $Global:Chainsaw.Console.Levels = $Levels
                }
                if( [string]::IsNullOrEmpty($MessageTemplate) -eq $false){
                    $Global:Chainsaw.Console.MessageTemplate = $MessageTemplate
                }
            }
        }
        else {
            # Working in Script Scope
            # Checking for JsonConfig
            if ( [string]::IsNullOrEmpty($JsonConfig)-eq $false ){
                $json = Get-Content -Path $JsonConfig | ConvertFrom-Json
                
                if ( [string]::IsNullOrEmpty($json.Console.Levels) -eq $false){
                    $Script:Chainsaw.Console.Levels = $json.Console.Levels
                }

                if ( [string]::IsNullOrEmpty($json.Console.MessageTemplate)-eq $false){
                    $Script:Chainsaw.Console.MessageTemplate = $json.Console.MessageTemplate
                }
            }
            
            # No Json was found, checking for manual load
            else {
                if( [string]::IsNullOrEmpty($Levels) -eq $false) {
                    $Script:Chainsaw.Console.Levels = $Levels
                }
                
                if( [string]::IsNullOrEmpty($MessageTemplate) -eq $false){
                    $Script:Chainsaw.Console.MessageTemplate = $MessageTemplate
                }
            }
        }
    }
}