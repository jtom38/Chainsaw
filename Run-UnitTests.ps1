
# Import the new class file we built
Import-Module .\Chainsaw\Chainsaw.psm1 -Force
. .\Chainsaw\ChainsawClasses.ps1 -Force

# Import Pester to run our tests
Import-Module Pester

Write-Verbose -Message "Starting tests on Classes"
. .\Tests\Csv.Test.ps1
. .\Tests\Console.Test.ps1

Write-Verbose -Message "Starting tests on Functions."
. .\Tests\New-ChainsawConfig.Test.ps1
