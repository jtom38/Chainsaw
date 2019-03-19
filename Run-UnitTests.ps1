
param(
    [string] $TeamsURL
)

# Import the new class file we built
. .\Run-Install.ps1
Import-Module "$PSSCRIPTROOT\Chainsaw\Chainsaw.psm1" -Force

# Import Pester to run our tests
Import-Module Pester
Invoke-Pester -Script "$($PSSCRIPTROOT)\Tests\"
