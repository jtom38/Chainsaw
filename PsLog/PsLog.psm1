#Requires -Version 5.0
[cmdletbinding()]
param()

#Add-Type -Path "$PSScriptRoot\Lib\MimeKit.dll" -ErrorAction SilentlyContinue
#Add-Type -Path "$PSScriptRoot\Lib\MailKit.dll" -ErrorAction SilentlyContinue

[Reflection.Assembly]::LoadFile("$PSScriptRoot\Lib\MimeKit.dll")
[Reflection.Assembly]::LoadFile("$PSScriptRoot\Lib\MailKit.dll")
# Test Mailkit

try {
    $client = [MailKit.Net.Smtp.SmtpClient]::new()
    if ( $client.IsConnected -eq $false ) {
        # We imported correctly.
    }
} 
catch {

}

# Import Classes
$Classes = @(
    "TemplateConverter.ps1",
    "PSLogConsole.ps1",
    "PSLogCsv.ps1",
    "PSLogEventLog.ps1",
    "PSLogSmtp.ps1",
    "PSLog.ps1"
)

foreach ( $class in $Classes ) {
    . "$PSScriptRoot\Classes\$class"
}

# Import General functions 

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
