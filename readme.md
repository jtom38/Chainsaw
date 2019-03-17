# Chainsaw

## About

This project was designed around easy logging and also gives flex regarding how and where you want your logs to go.  I enjoyed working with [NLog](https://nlog-project.org) when I do C# work but more I had needed to automate processes with PowerShell but was not happy with some of the logging I found.  So with that, I started to work on this project Chainsaw to hopefully make logging easier for others and myself.

## Targets

If you use NLog you will know they have different targets so where you can write logs.  I went with the same general idea.  Currently, the following targets are enabled.

* [Console](https://github.com/luther38/Chainsaw/blob/master/docs/Targets/Console.md)
* [CSV](https://github.com/luther38/Chainsaw/blob/master/docs/Targets/CSV.md)
* [EventLog](https://github.com/luther38/Chainsaw/blob/master/docs/Targets/EventLog.md)
* Microsoft Teams Webhook
* SMTP - TBD
* MSSQL - TBD

Wishlist

* Discord Webhook
* Slack

## Install

Module is available on PowerShell Galery so it is easy to install and update

```PowerShell
Install-Module -Name Chainsaw
Update-Module -Name Chainsaw
```

## How to Use

1. Import Chainsaw
2. Enable desired Targets

```PowerShell
Enable-ChainsawConsole -Levels @("Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Information", "Debug") -MessageTemplate '#DateTime# #Level# #Message#'

Enable-ChainsawCsv -LogPath '.\log.csv' -Levels @("Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Information", "Debug") -MessageTemplate "#DateTime#, #Level#, #CallingFile#, #ErrorCode#, #LineNumber#, #Message#"

Enable-ChainsawTeams -URI "https://FakeUrl.com" -Levels @("Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Information", "Debug") -MessageTitle 'Message From Chainsaw'
```

3. Log Messages

```PowerShell
Invoke-ChainsawMessage -Debug -Message 'Testing Chainsaw' -ErrorCode 100 -CallingFile $(Get-CurrentFileName) -LineNumber $(Get-CurrentLineNumber)
```

## Config 

You can backup your config and store it in a JSON file.

```PowerShell
Export-ChainsawConfig -JsonPath '.\chainsaw.json'
```