#Requires -Version 5.0

Write-Debug -Message "Looking for all files in Public"
$Public =  @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)

Write-Debug -Message "Looking for all files in Private"
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

foreach($import in @($Public + $Private)){

    try{
        . $import.fullname
    }catch{
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

[hashtable] $script:Chainsaw = @{
    ph = "coo"
    CSV = @{
        LogPath = ""
        Levels = @()
        MessageTemplate = ""
    }
    Console = @{
        Levels = @()
        MessageTemplate = ""
    }
    EventViewer = @{

    }
    Teams = @{

    }
}

Export-ModuleMember -Function $Public.Basename
#Export-ModuleMember -Function $importClasses.Basename