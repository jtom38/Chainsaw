

Import-Module Chainsaw -Force

[string[]] $Levels = @("Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Info", "Debug")

Enable-ChainsawConsole -Levels $Levels `
    -MessageTemplate '#DateTime# - #Level# - #Message#'

Enable-ChainsawCsv -LogPath '.\chainsaw.csv' `
    -Levels $Levels `
    -MessageTemplate "#DateTime#, #Level#, #CallingFile#, #ErrorCode#, #LineNumber#, #Message#"

Enable-ChainsawTeams -URI "Enter WebHook URL" `
    -Levels @('Debug') `
    -MessageTitle 'Process Name Here'

# Sending the message the Console and CSV
Invoke-ChainsawMessage -Error -Message "Something broke"

# Sending the message to Console
Invoke-ChainsawMessage -Info -Message "All systems are good"

# CSV will catch all the values passed but Console will only show you three of them.
Invoke-ChainsawMessage -Info -Message "All systems are good" `
    -CallingFile $(Get-CurrentFileName) `
    -LineNumber $(Get-CurrentLineNumber) `
    -ErrorCode 100

# How to handle Exceptions
try{
    throw 'Throwing a error now catch me!~'
}catch{
    Invoke-ChainsawMessage -Error `
        -Exception $PSitem `
        -CallingFile (Get-CurrentFileName) `
        -LineNumber (Get-CurrentLineNumber) `
        -ErrorCode 100
}

# Export our config so we can use it with ConfigDefinedLogger.ps1
Export-ChainsawConfig -JsonPath '.\chainsaw.json' -Force

# If for any reason you need to remove a logger you can do so
#Revoke-ChainsawEndpoint -Console -CSV -Force