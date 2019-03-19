
param(
    [string] $TeamsURL
)

# Import the new class file we built
. .\Run-Install.ps1
Import-Module "$PSSCRIPTROOT\Chainsaw\Chainsaw.psm1" -Force

# Import Pester to run our tests
Import-Module Pester

. $PSSCRIPTROOT\Tests\TargetConsole.Test.ps1
. $PSSCRIPTROOT\Tests\TargetCSV.Test.ps1
. $PSSCRIPTROOT\Tests\TargetTeams.Test.ps1 