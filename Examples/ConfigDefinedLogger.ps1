

Import-Module Chainsaw

Enable-ChainsawConsole -JsonConfig '.\chainsaw.json'

Enable-ChainsawCsv -JsonConfig '.\chainsaw.json'

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
# Export our config so we can use it with CodeDefinedLogger.ps1
Export-ChainsawConfig -JsonPath '.\chainsaw.json'

# Clear out our session
Revoke-ChainsawEndpoint -Console -CSV -Force