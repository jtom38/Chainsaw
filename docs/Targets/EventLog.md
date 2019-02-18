# Target - EventLog

## Description

This target allows you to enable the process you are building to be able to write to the EventLog depending on the type of message it is.  I use it to make it easier to have external log monitoring software be able to see what is going on with my services.  Depending on how you have it configured you can load your configuration via JSON or with inline code.  More information on that will be below.

## Getting started with EventLog Target

If you need to generate a new log on the computer that will run this process, use the code below.  You will need to run PowerShell as an administrator for this to work.  You will want to do this before you start to expect logs to generate.

```Powershell

using module .\ChainsawClasses.psm1
$Levels = @("Information", "Warning", "Error", "Debug")
$LogName = "Application"
$Source = "Chainsaw"
$ev = [ChainsawEventLog]::new($Levels, $LogName, $Source)
$ev.InitializeLog()

```

Once you run the command you will have a new log for you to look at.  An error code will be 1 bound to the Source name you provided.

## Config File Layout

```JSON
{
    "Chainsaw" : {
        "EventLog" : {
            "Levels" : [
                "Warning",
                "Error"
            ],
            "LogName" : "Application",
            "Source" : "Chainsaw"
        }
    }
}
```

## Class Overview

### Constructors

```PowerShell
$LogName = "Application"
$Source = "Chainsaw"
$Levels = @("Information", "Warning", "Error", "Debug")

$eventlog = [ChainsawEventLog]::new()
$eventlog.LogName = $LogName
$eventlog.Source = $Source
$eventlog.Levels = $Levels

[ChainsawEventLog]::new($Levels, $LogName, $Source)

[ChainsawEventLog]::new(".\config.json")
```

### Properties

```PowerShell
[string[]] $Levels
[string] $LogName
[string] $Source
```

### Methods

```PowerShell
Write(Level, Message)
Write(Level, Message, ErrorCode)
Write(Level, Message, ErrorCode, CallingFile, LineNumber)
```
