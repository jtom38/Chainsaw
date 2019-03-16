

Import-Module Chainsaw

Enable-ChainsawConsole -JsonConfig '.\chainsaw.json'

Enable-ChainsawCsv -JsonConfig '.\chainsaw.json'

# Sending the message the Console and CSV
Invoke-ChainsawMessage -Error -Message "Something broke"

# Sending the message to Console
Invoke-ChainsawMessage -Info -Message "All systems are good"

# Export our config so we can use it with CodeDefinedLogger.ps1
Export-ChainsawConfig -JsonPath '.\chainsaw.json'

# Clear out our session
Revoke-ChainsawEndpoint -Console -CSV -Force