

function Invoke-ChainsawCsv {
    [cmdletbinding()]
    param (
        [string] $Level,
        [string] $Message,
        [int] $ErrorCode,
        [string] $CallingFile,
        [int] $LineNumber
    )
    
    Process{
        $hash = $Script:Chainsaw.Csv
        $resultPath = Test-Path -Path $hash.LogPath
        


    }

}