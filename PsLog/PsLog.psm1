
$packages = split-path -parent $MyInvocation.MyCommand.Definition
add-type -path (Join-Path $packages "\PSLog\Lib\MailKit.dll") | Out-Null

#$classes = Get-ChildItem -Path $PSScriptRoot\Classes\*.ps1

$classes = @(
    "FileLock.ps1",
    "TemplateConverter.ps1",
    "PSLogConsole.ps1",
    "PSLogCsv.ps1",
    "PSLogEventLog.ps1",
    "PSLog.ps1"
)

foreach ( $c in $classes ) {
    $file = "$PSScriptRoot\Classes\$c"
    . $file
}

$log = [PSLog]::new()

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

Export-ModuleMember -Function $Public.Basename
