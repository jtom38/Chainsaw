
Add-Type -Path "$PSScriptRoot\Lib\MimeKit.dll" | Out-Null
Add-Type -Path "$PSScriptRoot\Lib\MailKit.dll" | Out-Null

# Test Mailkit

try {
    $client = [MailKit.Net.Smtp.SmtpClient]::new()
    if ( $client.IsConnected -eq $false ) {
        # We imported correctly.
    }
} 
catch {

}
