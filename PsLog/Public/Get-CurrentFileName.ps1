
function Get-CurrentFileName {
    Process{
        $info = [System.IO.FileInfo]::new($MyInvocation.ScriptName)
        return $info.Name
    }    
}