

Import-Module ..\Chainsaw\Chainsaw.psm1 -Force

Enable-ChainsawConsole -Levels @("Error", "Info", "Debug") `
    -MessageTemplate '#DateTime# - #Level# - #Message#'

Enable-ChainsawCsv -LogPath '.\chainsaw.csv' `
    -Levels @("Error") `
    -MessageTemplate "#DateTime#, #Level#, #Message#"

# Sending the message the Console and CSV
Invoke-ChainsawMessage -Error -Message "Something broke"

# Sending the message to Console
Invoke-ChainsawMessage -Info -Message "All systems are good"

# Export our config so we can use it with CodeDefinedLogger.ps1
Export-ChainsawConfig -JsonPath '.\chainsaw.json' -Force

# Clear out our session
Revoke-ChainsawEndpoint -Console -CSV -Force