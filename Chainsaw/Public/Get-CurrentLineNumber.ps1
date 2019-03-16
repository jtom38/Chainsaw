
<#
.Synopsis
Wrapper function to return $MyInvocation.ScriptLineNumber

.Description
Use this in debuging where a message came from.

.Example

Invoke-ChainsawMessage -Debug -Message "What line number is this?" -LineNumber $(Get-CurrentLineNumber)
Get-CurrentLineNumber

.Outputs
[int]
#>
function Get-CurrentLineNumber {
    return $MyInvocation.ScriptLineNumber    
}