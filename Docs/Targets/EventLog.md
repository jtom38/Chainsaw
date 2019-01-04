# Target - EventLog

## Description

This will let you write to the Windows Event Viewer.  This uses the *-EventLog commands currently to do its work.  I recommend that you run ths setup commands before you need your script to work.  This way you can test to confirm that it is working for you.

## Setup

If you do not run your process as an administrator I have some commands that you will need to run to be ready for this endpoint.

```Powershell

$Levels = @("Information", "Warning", "Error", "Debug")
$LogName = "Application"
$Source = "PSLog"
$ev = [PSLogEventLog]::new($Levels, $LogName, $Source)
$ev.InitializeLog()

```