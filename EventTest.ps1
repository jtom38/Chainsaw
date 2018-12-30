
#Write a log with .net
# https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.eventlog?view=netframework-4.7.2#methods
$event = [System.Diagnostics.EventLog]::new()
$event.Log = "Application"
$event.Source = "PSLog"
$event.WriteEntry("Message", [System.Diagnostics.EventLogEntryType]::Information, 1)

# Check to see if we find any events for where we want to log
$ConfigPath = "C:\Users\James\Documents\GitHub\PSLogCsv\config.json"
$Config = Get-Content -Path $ConfigPath | ConvertFrom-Json

$t = Get-EventLog -LogName $Config.PSLog.EventViewer.LogName -Source $Config.PSLog.EventViewer.Source -Newest 1 | Measure-Object
if ( $t.Count -eq 0) {
    try {
        New-EventLog -LogName $Config.PSLog.EventViewer.LogName -Source $Config.PSLog.EventViewer.Source
        Write-EventLog -LogName $Config.PSLog.EventViewer.LogName -Source $Config.PSLog.EventViewer.Source -EventID 1 -EntryType Information -Message "New log was initialized by $ENV:Username"
    } catch {

    }
}


$LogName = "Application"
$Source = "PSLog"

$t = Get-EventLog -LogName $LogName -Source $Source -Newest 1 | Measure-Object
if ( $t.Count -eq 0) {
    try {
        New-EventLog -LogName $LogName -Source $Source
        Write-EventLog -LogName $LogName -Source $Source -EventID 1 -EntryType Information -Message "New log was initialized by $ENV:Username"
    } catch {

    }  
}