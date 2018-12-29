# Event Log EndPoint

## Description

This will let you write to the Windows Event Viewer.  This uses the *-EventLog commands currently to do its work.  If you enable this end point you will need to make sure that you initialized the logs as an Administrator.  If you are running your process with Administrator permissions it will create the required logs for you.

If you do not run your process as an administrator I have some commands that you will need to run to be ready for this endpoint.

```Powershell

# Open PowerShell as Administrator
# Pull in your config file to memory
$ConfigPath = ".\config.json"
$Config = Get-Content -Path $ConfigPath | ConvertFrom-Json

New-EventLog -LogName $Config.EventViewer.LogName -Source $Config.EventViewer.Source

Write-EventLog -LogName $Config.EventViewer.LogName -Source $Config.EventViewer.Source -EventID 3001 -EntryType Information -Message "New log was initialized by $ENV:Username"

```