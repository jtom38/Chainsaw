
Import-Module .\Chainsaw\Chainsaw.psm1 -Force

Enable-ChainsawConsole -Levels @("Info") -MessageTemplate '[#DateTime#] [#Level#] #Message#'
Enable-ChainsawCsv -Levels @("Info") -MessageTemplate '#DateTime#, #Level#, #Message#' -LogPath './log.csv'
Invoke-ChainsawMessage -Info -Message "Test"

