
<#
.Synopsis
This returns the current line number that it was called from.
Use this in debuging where a message came from.
#>
function Get-CurrentLineNumber {
    return $MyInvocation.ScriptLineNumber    
}