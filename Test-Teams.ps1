
Import-Module .\Chainsaw\Chainsaw.psm1 -Force

Enable-ChainsawConsole -Levels @("Emergency") -MessageTemplate '[#DateTime#] [#Level#] [#CallingFile#] [#ErrorCode#] [#LineNumber#] #Message#'
#Enable-ChainsawCsv -Levels @("Emergency") -MessageTemplate '#DateTime#, #Level#, #CallingFile#, #ErrorCode#, #LineNumber#, #Message#' -LogPath './log.csv'
#Enable-ChainsawCsv -JsonConfig ".\Export.json" -ScopeGlobal
#[hashtable] $h = $Script:Chainsaw.CSV

Revoke-ChainsawConsole -Force

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
