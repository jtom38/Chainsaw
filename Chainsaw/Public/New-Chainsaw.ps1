
<#
.Synopsis
Returns 
#>
function New-Chainsaw {
    param(
        # Loads the dev classes into memory
        [switch] $Dev
    )


    if( $Dev ){
        . "$($PSScriptRoot)\ChainsawClassesDev.ps1"
    } else {
        . "$($PSScriptRoot)\ChainsawClasses.ps1"
    }

    return [Chainsaw]::new()
    
}