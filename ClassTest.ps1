
# Import the classes 
. "$psscriptroot\PsLogCsv\Classes\TemplateConverter.ps1"
. "$psscriptroot\PsLogCsv\Classes\"
. "$psscriptroot\PsLogCsv\Classes\PSLogConsole.ps1"
. "$psscriptroot\PsLogCsv\Classes\PSLogCsv.ps1"
. "$psscriptroot\PsLogCsv\Classes\PsLog.ps1"

#Generate the CSV Settings based off the config file
$CsvJson = [CsvSettings]::new(".\config.json")

# Generate the CSV Settings based off manual loading
$MessageTemplate = "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#"
$Levels = @("Information", "Warning", "Error", "Debug")
$CsvManual = [CsvSettings]::new(".\log.csv", $MessageTemplate, $Levels) 

# Generate the Console Settings based off the config file
$LogConsole = [ConsoleSettings]::new(".\config.json")

# Generate a blank PsLogger
$Logger = [PsLog]::new()

# Define what endpoints we are goign to enable
$Logger.ConsoleConfig = $LogConsole
$Logger.CsvConfig = $CsvJson

# Start passing messages
$Logger.Info("Test Info Message", $Logger.GetCurrentFileName(), $Logger.GetCurrentLineNumber())
$Logger.Error("Test Error Message", $Logger.GetCurrentFileName(), $Logger.GetCurrentLineNumber())
$Logger.Warning("Test Warning Message", $Logger.GetCurrentFileName(), $Logger.GetCurrentLineNumber())
$Logger.Debug("Test Debug Message", $Logger.GetCurrentFileName(), $Logger.GetCurrentLineNumber())