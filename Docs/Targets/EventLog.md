# Target - EventLog

## Description

This target alows you to enable the process you are building to be able to write to the EventLog depending on the type of message it is.  I use it to make it easier to have external log monitoring software be able to see what is going on with my services.  Depending on how you have it configured you can load your configuration via JSON or with inline code.  More information on that will be below.

## Getting started with EventLog Target

If you need to generate a new log on the computer that will run this process, use the code below.  You will need to run PowerShell as an administrator for this to work.  You will want to do this before you start to expect logs to generate.

```Powershell

using module .\PSLogClasses.psm1
$Levels = @("Information", "Warning", "Error", "Debug")
$LogName = "Application"
$Source = "PSLog"
$ev = [PSLogEventLog]::new($Levels, $LogName, $Source)
$ev.InitializeLog()

```

Once you run the command you will have a new log for you to look at.  Error code will be 1 bound to the Source name you provided.

## Class

Initilization of Target

Building it from inline code

```PowerShell

$Logger = [PSLog]::new()
$Levels = @("Information", "Warning", "Error", "Debug")
$LogName = "Application"
$Source = "PSLog"
$Logger.EventLogConfig = [PSLogEventLog]::new($Levels, $LogName, $Source)
$Logger.Info("I am a test message")
```

Building it from Json config

```Json
{
    "PSLog": {
        "EventLog" : {
            "Levels" : [
                "Warning",
                "Error"
            ],
            "LogName" : "Application",
            "Source" : "PSLog"
        }
    }
}
```

```PowerShell
$Logger = [PSLog]::new()
$Logger.EventLogConfig = [PSLogEventLog]::new(".\config.json")
$Logger.Info("I am a test message")
```