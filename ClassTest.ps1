
# Import the classes 
#using module .\PSLog\PSLogClasses.psm1



$packages = split-path -parent $MyInvocation.MyCommand.Definition
#add-type -path (Join-Path $packages "MimeKit.dll") | Out-Null
add-type -path (Join-Path $packages "MailKit.dll") | Out-Null

$client = [MailKit.Net.Smtp.SmtpClient]::new()


# Generate a blank PsLogger
$Logger = [PsLog]::new()

# Define what endpoints we are goign to enable
$Logger.ConsoleConfig = [PSLogConsole]::new(".\config.json")
$Logger.CsvConfig = [PSLogCsv]::new(".\config.json")
$Logger.EventLogConfig = [PSLogEventLog]::new(".\config.json")

<#Used to as an example on how to generate a new Source
$Levels = @("Information", "Warning", "Error", "Debug")
$LogName = "Application"
$Source = "PSLog"
$Logger.EventLogConfig = [PSLogEventLog]::new($Levels, $LogName, $Source)
$LogExists = $Logger.EventLogConfig.InitializeLog()
#>

# Start passing messages
$Logger.Info("Message")
$Logger.Info("Message and ErrorCode", 1)
$Logger.Info("Message, ErrorCode, LineNumber, Calling File", 2, $Logger.GetCurrentFileName(), $Logger.GetCurrentLineNumber() )

$Logger.Warning("Message")
$Logger.Warning("Message and ErrorCode", 1)
$Logger.Warning("Message, ErrorCode, LineNumber, Calling File", 2, $Logger.GetCurrentFileName(), $Logger.GetCurrentLineNumber() )

$Logger.Error("Message")
$Logger.Error("Message and ErrorCode", 1)
$Logger.Error("Message, ErrorCode, LineNumber, Calling File", 2, $Logger.GetCurrentFileName(), $Logger.GetCurrentLineNumber() )

$Logger.Debug("Message")
$Logger.Debug("Message and ErrorCode", 1)
$Logger.Debug("Message, ErrorCode, LineNumber, Calling File", 2, $Logger.GetCurrentFileName(), $Logger.GetCurrentLineNumber() )
