

function Invoke-ChainsawCsv {
    [cmdletbinding()]
    param (
        [string] $Level,
        [string] $Message,
        [int] $ErrorCode,
        [string] $CallingFile,
        [int] $LineNumber,
        [psobject] $Exception
    )
    
    Process{
        # Get the config for easy access
        $hash = Get-ChainsawConfig -CSV

        # Check to see if we need to generate a new file
        #$info = [System.IO.FileInfo]::new($hash.LogPath)
        [bool] $res = Test-Path -Path $hash.LogPath
        if( $res -eq $false){
            $headerMsg = Format-ChainsawMessage `
                -Header `
                -Template $hash.MessageTemplate

            New-Item -Path $hash.LogPath `
                -Value "$($headerMsg)`r" | Out-Null
        }

        # If we have an Exception extract the message and replace our message
        if( $Exception -ne $null){
            $Message = $Exception.TargetObject
        }

        # Get our message from the Template
        $msg = Format-ChainsawMessage `
            -Template $hash.MessageTemplate `
            -Level $Level `
            -Message $Message `
            -ErrorCode $ErrorCode `
            -CallingFile $CallingFile `
            -LineNumber $LineNumber

        Add-Content -Path $hash.LogPath `
            -Value "$($msg)`r"
    }
}