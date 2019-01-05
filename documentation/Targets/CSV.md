# Endpoint - CSV

## Config File Layout

```JSON
{
    "PsLog" : {
        "CSV" : {
            "Levels" : [
                "Information",
                "Warning",
                "Error",
                "Debug"
            ],
            "LogPath" : ".\\log.csv",
            "MessageTemplate" : "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"
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

$csv = [PSLogCsv]::new()
$csv.LogPath = $LogPath
$csv.MessageTemplate = $MessageTemplate
$csv.Levels = $Levels

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