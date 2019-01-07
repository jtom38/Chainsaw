
# This script is here to show how to get PSLog to work correctly given PowerShell limmitations.

# 1. Make a entry script to Import-Module PSLog
Import-Module .\PsLog\PsLog.psm1

# 2. Call Import-PSLogDepends to import required Libararies
Import-PSLogDepends

# Call the script that you made
. .\RealScriptHere.ps1

# first line of RealScriptHere.ps1 needs to have the following to get access to classes
# PowerShell needs to read the classes at the start of the script to make sure it loads in correctly.
# Problem is when you have requirements that need to be meet before the classes, we have to make a entry point script.
using module .\PsLog\PSLogClasses.psm1