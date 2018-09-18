
function Send-CsvMessage {
    param (
        [string] $Message,
        [string] $Level
    )
    
    Process { 
        
        if( [System.String]::IsNullOrEmpty($Message) -eq $true ){
            throw 
        }

        if( [System.String]::IsNullOrEmpty($Level) -eq $true ){
            throw 
        }

        # Get the values from the HashTable
        $LogPath = $script:PsLogCsv.LogPath
        $Template = $script:PsLogCsv.Template
        

        # Check to see if out log file exists
        if( [System.IO.File]::Exists($LogPath) -eq $false) {
            $info = [System.IO.FileInfo]::new($LogPath)
            New-Item -Path $info.Directory -Name $info.Name -ItemType "file" | Out-Null

            # Generate the header
            $header = Get-CsvHeader -CsvLogFormat $Template

            # Write the header
            Add-Content -Path $LogPath -Value $header
        }

        # Generate the log Message
        $msg = Convert-ToCsvMessage -Level $Level -Message $Message -LogFormat $Template -LineNumber $LineNumber -CallingFile $CallingFile

        # Time to write our log
        Add-Content -Path $LogPath -Value $msg

        # Write to Console
        $ConsoleMessage = Convert-ToConsoleMessage -Level $Level -Message $Message
        [Console]::WriteLine($ConsoleMessage)
    }
}