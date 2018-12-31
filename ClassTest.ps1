
# Import the classes 
using module .\PSLog\PSLogClasses.psm1

#Generate the CSV Settings based off the config file
$CsvJson = [PSLogCsv]::new(".\config.json")

# Generate the CSV Settings based off manual loading
#$MessageTemplate = "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#"
#$Levels = @("Information", "Warning", "Error", "Debug")
#$CsvManual = [PSLogCsv]::new(".\log.csv", $MessageTemplate, $Levels) 

# Generate the Console Settings based off the config file
$LogConsole = [PSLogConsole]::new(".\config.json")

# Generate a blank PsLogger
$Logger = [PsLog]::new()

# Define what endpoints we are goign to enable
$Logger.ConsoleConfig = $LogConsole
$Logger.CsvConfig = $CsvJson

# Start passing messages
$Logger.Info("-Test- Message Only")
$Logger.Info("Message and ErrorCode", 1)
$Logger.Info("Message, ErrorCode, LineNumber, Calling File", 2, $Logger.GetCurrentFileName(), $Logger.GetCurrentLineNumber() )

$Logger.Warning("Message")
$Logger.Warning("Message and ErrorCode", 1)
$Logger.Warning("Message, ErrorCode, LineNumber, Calling File", 2, $Logger.GetCurrentFileName(), $Logger.GetCurrentLineNumber() )


$Logger.Error("Test Error Message", $Logger.GetCurrentFileName(), $Logger.GetCurrentLineNumber())
$Logger.Warning("Test Warning Message", $Logger.GetCurrentFileName(), $Logger.GetCurrentLineNumber())
$Logger.Debug("Test Debug Message", $Logger.GetCurrentFileName(), $Logger.GetCurrentLineNumber())