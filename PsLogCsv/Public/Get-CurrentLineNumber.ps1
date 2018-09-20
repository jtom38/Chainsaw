
function Get-CurrentLineNumber {
    Process{
        return $MyInvocation.ScriptLineNumber
    }
}