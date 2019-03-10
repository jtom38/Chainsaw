

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
        # Get the config for easy access
        $hash = $Script:Chainsaw.Csv

        # Check to see if we need to generate a new file
        $info = [System.IO.FileInfo]::new($hash.LogPath)
        if( $info.Exists -eq $false){
            $headerMsg = Format-ChainsawMessage `
                -Header `
                -Template $hash.MessageTemplate

            New-Item -Path $info.Directory.FullName `
                -ItemType "file" `
                -Name $info.Name `
                -Value "$($headerMsg)`r`n" | Out-Null
        }

        # Get our message from the Template
        $msg = Format-ChainsawMessage `
            -Template $hash.MessageTemplate `
            -Level $Level `
            -Message $Message `
            -ErrorCode $ErrorCode `
            -CallingFile $CallingFile `
            -LineNumber $LineNumber

        Add-Content -Path $info.FullName `
            -Value "$($msg)`r`n"
    }
}