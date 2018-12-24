Write-Debug -Message "Looking for all files in Public"
$Public =  @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)

Write-Debug -Message "Looking for all files in Private"
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

$Classes = @( Get-ChildItem -Path $PSScriptRoot\Classes\*.ps1 -ErrorAction SilentlyContinue)

foreach($import in @($Public + $Private + $Classes)){

    try{
        . $import.fullname
    }catch{
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename
