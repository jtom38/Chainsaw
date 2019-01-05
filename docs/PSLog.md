# PSLog

This is the primary entry point for this library.  You will pass all your requests through this class and it will handle the distribution of the event.

## Class Overview

### Constructors

```PowerShell
[PSLog]::new()
```

### Properties

```PowerShell
[PSLogCsv] $CsvConfig
[PSLogConsole] $ConsoleConfig
[PSLogEventLog] $EventLogConfig
```

### Methods

```PowerShell
    [void] Info( [string] $Message )
    [void] Info( [string] $Message, [int] $ErrorCode )
    [void] Info( [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber)

    [void] Error( [string] $Message )
    [void] Error( [string] $Message, [int] $ErrorCode )
    [void] Error( [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber)

    [void] Warning( [string] $Message )
    [void] Warning( [string] $Message, [int] $ErrorCode )
    [void] Warning( [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber)

    [void] Debug( [string] $Message )
    [void] Debug( [string] $Message, [int] $ErrorCode )
    [void] Debug( [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber)

    [int] GetCurrentLineNumber()
    [string] GetCurrentFileName()
```