
# Import the classes 
using module .\PSLog\PSLogClasses.psm1

#Generate the CSV Settings based off the config file
#$CsvJson = [PSLogCsv]::new(".\config.json")

# Generate the CSV Settings based off manual loading
#$MessageTemplate = "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#"
#$Levels = @("Information", "Warning", "Error", "Debug")
#$CsvManual = [PSLogCsv]::new(".\log.csv", $MessageTemplate, $Levels) 

# Generate the Console Settings based off the config file
#$LogConsole = [PSLogConsole]::new(".\config.json")

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
