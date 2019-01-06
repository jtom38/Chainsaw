using module .\PSLog\PSLogClasses.psm1

$packages = split-path -parent $MyInvocation.MyCommand.Definition
add-type -path (Join-Path $packages "\PSLog\Lib\MailKit.dll") | Out-Null

$client = [MailKit.Net.Smtp.SmtpClient]::new()
$client.Connect("smtp.gmail.com", 465, $true)

if ( $client.IsConnected -eq $true ) {
    Write-Host "Connected to SMTP Server"
}
else {
    Write-Host "Failed to connect to SMTP server"
}

$client.Disconnect($true)