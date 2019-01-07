
# Import the new class file we built
using module .\PsLog\PSLogClasses.psm1

# Import Pester to run our tests
Import-Module Pester

Write-Verbose -Message "Starting tests on Classes"
. .\Tests\Csv.Test.ps1
. .\Tests\Console.Test.ps1

#Write-Verbose -Message "Starting tests on Functions."
