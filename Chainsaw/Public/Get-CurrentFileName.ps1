
<#
.Synopsis
Use this to return the calling files name.
Use this to find the source of a calling message.

.Example 
Invoke-ChainsawMessage -Debug -Message "What file is this?" -CallingFile $(Get-CurrentFileName)
Get-CurrentFileName

.Outputs
[string] 
#>
function Get-CurrentFileName {
    $info = [System.IO.FileInfo]::new($MyInvocation.ScriptName)
    return $info.Name
}