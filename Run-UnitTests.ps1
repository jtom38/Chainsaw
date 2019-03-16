
# Import the new class file we built
. .\Run-Install.ps1
Import-Module Chainsaw -Force

# Import Pester to run our tests
Import-Module Pester

. .\Tests\TargetConsole.Test.ps1
. .\Tests\TargetCSV.Test.ps1
. .\Tests\TargetTeams.Test.ps1