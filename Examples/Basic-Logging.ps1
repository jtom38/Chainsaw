
# This script is here to show how to get PSLog to work correctly given PowerShell limmitations.

# 1. Make a entry script to Import-Module PSLog
Import-Module .\PsLog\PsLog.psm1 -Force

# 2. Import the classes
. .\PsLog\PSLogClasses.ps1 -Force

# 3. Generate a new local PSLog Instance
$logger = [PSLog]::new()

# 3a. If you want it to be global and access it from other layers of the application
$Global:logger = [PSLog]::new()

# 4. Generate your targets
$logger.ConsoleConfig = [PSLogConsole]::new(".\config.json")
$logger.CsvConfig = [PSLogCsv]::new(".\config.json")
$logger.EventLogConfig = [PSLogEventLog]::new(".\config.json")

# 5. Write your messages
$logger.Info("I have a message for you!")