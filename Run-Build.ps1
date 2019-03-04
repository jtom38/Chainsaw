<#
.Description
Due to how PowerShell handles classes this was built to take all the classes that I have in seperate files and merger them into one file.  
This way to import the lib you just call one file.

This is my building file.  Use this if you want to build a fresh class module if you made changes to the source.
#>

$prod = "$psscriptroot\Chainsaw\Public\ChainsawClasses.ps1"
$dev = "$psscriptroot\Chainsaw\Public\ChainsawClassesDev.ps1"

Write-Host "Starting build of Dev Classes."
Write-Host "Building class file based off of .\Chainsaw\Classes"
# Define where the classes are and pull them into memory
$Files = Get-ChildItem -Path .\Chainsaw\Classes

# Define where the new Module file will be
#$ClassModule = "$psscriptroot\Chainsaw\ChainsawClasses.ps1"
if ( [System.IO.File]::Exists($dev) -eq $true ) {
    # Delete the old one
    [System.IO.File]::Delete($dev)
}

# Generate the new blank file
New-Item -Path ".\Chainsaw\Public" -Name "ChainsawClassesDev.ps1" | Out-Null

$dt = [datetime]::Now
Add-Content -Path $dev -Value "# Generated $dt"
# Loop though each file and take the content and place it in the new file
foreach ( $f in $Files) {

    $raw = Get-Content $f.FullName

    Add-Content -Path $dev -Value $raw
    
}

# We use a explicit list for classes that have been tested
Write-Host "Starting build of Prod Classes."
if ( [System.IO.File]::Exists($prod) -eq $true ) {
    # Delete the old one
    [System.IO.File]::Delete($prod)
}

# Generate the new blank file
New-Item -Path ".\Chainsaw\Public" -Name "ChainsawClasses.ps1" | Out-Null

$dt = [datetime]::Now
Add-Content -Path $prod -Value "# Generated $dt"
# Loop though each file and take the content and place it in the new file

$Files = @(
    "$psscriptroot\Chainsaw\Classes\TemplateConverter.ps1",
    "$psscriptroot\Chainsaw\Classes\ChainsawConsole.ps1",
    "$psscriptroot\Chainsaw\Classes\ChainsawCsv.ps1",
    "$psscriptroot\Chainsaw\Classes\ChainsawEventLog.ps1",
    "$psscriptroot\Chainsaw\Classes\Chainsaw.ps1"
)

foreach ( $f in $Files) {

    $i = Get-ChildItem -Path $f
    $raw = Get-Content $i.FullName

    Add-Content -Path $prod -Value $raw
    
}

# Run the installer so we can call the module by name
Write-Host "Installing module into user profile"
.\Install.ps1

# Run the unit tests on the new build
Write-Host "Starting Unit Testing"
.\Run-UnitTests.ps1