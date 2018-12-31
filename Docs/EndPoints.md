# PSLog - Targets

## Console

### Description

This End Point will assist you with posting your logs to the console window.  This is a optional class that you do not have to use.

### Configuration

a

## EventLog

### Description

This will let you write to the Windows Event Viewer.  This uses the *-EventLog commands currently to do its work.  I recommend that you run ths setup commands before you need your script to work.  This way you can test to confirm that it is working for you.

### Setup

If you do not run your process as an administrator I have some commands that you will need to run to be ready for this endpoint.

```Powershell

$LogName = "Application"
$Source = "PSLog"


$t = Get-EventLog -LogName $LogName -Source $Source -Newest 1 | Measure-Object
if ( $t.Count -eq 0) {
    try {
        # Create a new log to store entries
        [System.Diagnostics.EventLog]::CreateEventSource($Source, $LogName)

        $event = [System.Diagnostics.EventLog]::new()
        $event.Source = $this.Source
        $event.Log = $this.LogName
        $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Information, 1)
        Write-EventLog -LogName $LogName -Source $Source -EventID 1 -EntryType Information -Message "New log was initialized by $ENV:Username"
    } catch {

    }  
}

```