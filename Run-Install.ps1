# This is a installer script to assist with dev work

#https://docs.microsoft.com/en-us/powershell/developer/module/installing-a-powershell-module
# Copy All Modules over to %UserProfile%\Documents\WindowsPowerShell\Modules


if ($IsWindows -eq $false ) {
    $PathUserModules = "~/.local/share/powershell/Modules/"
} else {
    $PathUserModules = "$($env:USERPROFILE)\Documents\WindowsPowerShell\Modules\"
}

$Modules = @(
    "Chainsaw"
)

foreach($m in $Modules){
    $PathModule = "$($PathUserModules)$($m)"

    $res = Test-Path -Path $PathModule

    # Check to see if the path exists
    if( $res -eq $true ){
        # Found it.  Remove it.
        Remove-Item -LiteralPath $PathModule -Force -Recurse
    }

    # Install our updates
    $p = "$($PSScriptRoot)\$($m)"
    Write-Host "Installing Module: $m" -ForegroundColor Green
    Copy-Item -Path $p -Destination $PathModule -Recurse

}