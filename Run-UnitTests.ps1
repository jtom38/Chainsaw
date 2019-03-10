
# Import the new class file we built
. .\Install.ps1
Import-Module Chainsaw -Force

# Import Pester to run our tests
Import-Module Pester

#. .\Tests\Import-Module.Test.ps1
. .\Tests\TargetConsole.Test.ps1
