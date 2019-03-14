
Import-Module .\Chainsaw\Chainsaw.psm1 -Force

#Enable-ChainsawConsole -Levels @("Emergency") -MessageTemplate '[#DateTime#] [#Level#] [#CallingFile#] [#ErrorCode#] [#LineNumber#] #Message#'
#Enable-ChainsawCsv -Levels @("Emergency") -MessageTemplate '#DateTime#, #Level#, #CallingFile#, #ErrorCode#, #LineNumber#, #Message#' -LogPath './log.csv'
Enable-ChainsawTeams `
    -URI 'https://outlook.office.com/webhook/0d940d2c-3c4f-4362-aecf-9565c3033af6@614450b6-f13d-4572-8bc7-b57eff53eab8/IncomingWebhook/461391eefc1e43e0b3e346de1dea60b8/cf190efe-f36d-4f27-a939-38dc8b3a9fbe' `
    -Levels @("Emergency") `
    -MessageTemplate '#DateTime#, #Level#, #CallingFile#, #ErrorCode#, #LineNumber#, #Message#' `
    -MessageTitle 'Title'

#Revoke-ChainsawConsole -Force

Invoke-ChainsawMessage -Emergency `
    -Message "Pester"

Invoke-ChainsawMessage -Emergency `
-Message "Pester" `
-CallingFile (Get-CurrentFileName)

Invoke-ChainsawMessage -Emergency `
-Message "Pester" `
-CallingFile (Get-CurrentFileName) `
-LineNumber (Get-CurrentLineNumber)

Invoke-ChainsawMessage -Emergency `
-Message "Pester" `
-CallingFile (Get-CurrentFileName) `
-LineNumber (Get-CurrentLineNumber) `
-ErrorCode 100

Export-ChainsawConfig -JsonPath .\Export.json -Force
