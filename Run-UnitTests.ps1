
# Import the new class file we built
Import-Module .\PsLog\PsLog.psm1
. .\PsLog\PSLogClasses.ps1 -Force

# Import Pester to run our tests
Import-Module Pester

Write-Verbose -Message "Starting tests on Classes"
. .\Tests\Csv.Test.ps1
. .\Tests\Console.Test.ps1

#Write-Verbose -Message "Starting tests on Functions."
