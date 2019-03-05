import-Module PSTeams


$s1 = New-TeamsSection `
    -Title "Testing from PSTeams" `
    -ActivityTitle "Soon to be added to Chainsaw" `

$uri = 'https://outlook.office.com/webhook/a382c6bb-36a4-4288-8ed1-1e0588f32e32@614450b6-f13d-4572-8bc7-b57eff53eab8/IncomingWebhook/132e0424acef46c19fd2a886a401d847/cf190efe-f36d-4f27-a939-38dc8b3a9fbe'
$dt = [datetime]::Now
Send-TeamsMessage `
    -URI $uri `
    -MessageTitle "ScriptName" `
    -MessageText "$env:USER - $($dt.ToShortDateString())" `
    -Sections $s1
    
