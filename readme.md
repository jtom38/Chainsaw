# Chainsaw

## About

This project started off as a CSV logger for some process updates that I needed to make.  But over time it grew into a project that would let me add new loggers as the team needed/wanted more ways to send log information.  I did not want to have to keep adding more lines just for different loggers so Chainsaw came to fix that issue.

With Chainsaw you can enable different targets and define what message will go to that target.  If you only want Error messages to be passed to CSV, you can.  If you want to watch the process and see all messages you can enable that with the Console logger.  As new targets get added it will be the same message that is passed

## Targets

Targets are the core of what Chainsaw will work with.  Here are the currently available targets with the current version.

* Console
* CSV
* Microsoft Teams

Pending

* EventLog
* SMTP
* MSSQL
* Discord
* Slack

## Install

A module is available on PowerShell Galery so it is easy to install and update

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