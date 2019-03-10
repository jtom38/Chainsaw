
<#
.Synopsis
Lets you export the current running config to a file.

.Parameter JsonPath
Defines where we will export to.

.Parameter Force
Defines if we are going to overwrite the existing file.

.Example
Export-ChainsawConfig -JsonPath '.\chainsaw.json'
#>
function Export-ChainsawConfig {
    param (
        # Defines where we will export too
        [string] $JsonPath,

        # Force is here to overwrite the file
        [switch] $Force,

        [switch] $ScopeGlobal
    )
    
    Process{
        #$Info = [System.IO.FileInfo]::new($JsonPath)
        $res = Test-Path $JsonPath

        if ($res -eq $true) {
            if($Force){
                Remove-item -Path $JsonPath
            }
            else {
                Throw "File $JsonPath was already on disk.  To overwrite the config use -Force."
            }
        }

        if($ScopeGlobal){
            $json = $Global:Chainsaw | ConvertTo-Json
        }else{
            $json = $Script:Chainsaw | ConvertTo-Json
        }
        
        Out-File -FilePath $JsonPath -InputObject $json
    }
}