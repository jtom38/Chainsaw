
function Send-CsvMessage {
    param (
        [string] $Message,
        [string] $Level,
        [string] $CallingFile,
        [int] $LineNumber
    )
    
    Process { 
        
        if( [System.String]::IsNullOrEmpty($Message) -eq $true ){
            throw 
        }

        if( [System.String]::IsNullOrEmpty($Level) -eq $true ){
            throw 
        }

        # Get the values from the HashTable
        $LogPath = $global:LogCsvLogPath
        $Template = $global:LogCsvTemplate
        $ReturnMessage = $global:LogCsvReturnMessage

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

        # Check to see if the file is locked
        # I set this to true so we can force it to check the status.
        $FileLock = $true 
        while ( $FileLock -eq $true ){
            # If we get true then the file is locked and we will check again
            # if the result is false we where able to open the file in memory thus no lock.
            $FileLock = Get-FileLockStatus -File $LogPath

            # Only run the sleep if the file is locked.
            if ( $FileLock -eq $true ) {
                Start-Sleep -Seconds 1
            }        
        }

        # Time to write our log
        Add-Content -Path $LogPath -Value $msg

        # Write to Console
        $ConsoleMessage = Convert-ToConsoleMessage -Level $Level -Message $Message
        [Console]::WriteLine($ConsoleMessage)

        # if requested to return a message build it here
        if ( [System.String]::IsNullOrEmpty($ReturnMessage) -eq $false ) {
            $rMessage = Convert-ToCsvMessage -Level $Level -Message $Message -LogFormat $ReturnMessage -LineNumber $LineNumber -CallingFile $CallingFile
            return $rMessage
        }
    }
}