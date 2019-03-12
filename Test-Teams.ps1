
Import-Module .\Chainsaw\Chainsaw.psm1 -Force

Enable-ChainsawConsole -Levels @("Emergency") -MessageTemplate '[#DateTime#] [#Level#] [#CallingFile#] [#ErrorCode#] [#LineNumber#] #Message#'
Enable-ChainsawCsv -Levels @("Info") -MessageTemplate '#DateTime#, #Level#, #Message#' -LogPath './log.csv'
<#
Invoke-ChainsawMessage -Emergency `
    -Message "Pester"

Invoke-ChainsawMessage -Emergency `
-Message "Pester" `
-CallingFile (Get-CurrentFileName)

Invoke-ChainsawMessage -Emergency `
-Message "Pester" `
-CallingFile (Get-CurrentFileName) `
-LineNumber (Get-CurrentLineNumber)
#>
Invoke-ChainsawMessage -Emergency `
-Message "Pester" `
-CallingFile (Get-CurrentFileName) `
-LineNumber (Get-CurrentLineNumber) `
-ErrorCode 100
Export-ChainsawConfig -JsonPath .\Export.json
