
# This script is here to show how to get Chainsaw to work correctly given PowerShell limmitations.

# 1. Make a entry script to Import-Module Chainsaw
Import-Module .\Chainsaw\Chainsaw.psm1 -Force

# 2. Import the classes
. .\Chainsaw\ChainsawClasses.ps1 -Force

# 3. Generate a new local Chainsaw Instance
$logger = [Chainsaw]::new()

# 3a. If you want it to be global and access it from other layers of the application
$Global:logger = [Chainsaw]::new()

# 4. Generate your targets
$logger.ConsoleConfig = [ChainsawConsole]::new(".\config.json")
$logger.CsvConfig = [ChainsawCsv]::new(".\config.json")
$logger.EventLogConfig = [ChainsawEventLog]::new(".\config.json")

# 5. Write your messages
$logger.Info("I have a message for you!")