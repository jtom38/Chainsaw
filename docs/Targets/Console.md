# Endpoint - Console

## Config File Layout

```JSON
{
    "PsLog" : {
        "Console" : {
            "Levels" : [
                "Information",
                "Warning",
                "Error",
                "Debug"
            ],
            "MessageTemplate" : "[#DateTime#] [#Level#] #Message#"
        }
    }
}
```

## Class Overview

### Constructors

```PowerShell
$LogPath = ".\log.csv"
$MessageTemplate = "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"
$Levels = @("Information", "Warning", "Error", "Debug")

$console = [PSLogConsole]::new()
$console.LogPath = $LogPath
$console.MessageTemplate = $MessageTemplate
$console.Levels = $Levels

[PSLogCsv]::new($LogPath, $MessageTemplate, $Levels)

[PSLogCsv]::new(".\config.json")
```

### Properties

```PowerShell
[string] $LogPath
[string] $MessageTemplate
[string[]] $Levels
```

### Methods

```PowerShell
Write(Level, Message)
Write(Level, Message, ErrorCode)
Write(Level, Message, ErrorCode, CallingFile, LineNumber)
```