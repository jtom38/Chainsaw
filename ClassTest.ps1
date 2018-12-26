
# Import the classes from our module
using module .\PsLogCsv\Classes\ConsoleSettings.psm1
using module .\PsLogCsv\Classes\CsvSettings.psm1
using module .\PsLogCsv\Classes\PsLog.psm1


#Generate the CSV Config
$LogCsv = [CsvSettings]::new(".\config.json")


 