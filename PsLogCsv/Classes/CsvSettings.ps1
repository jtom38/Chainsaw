
class CsvSettings : TemplateConverter {
    
    CsvSettings([string] $LogPath, [string] $MessageTemplate, [string[]] $Levels) {
        $this.LogPath = $LogPath
        $this.MessageTemplate = $MessageTemplate
        $this.Levels = $Levels
    }

    CsvSettings([string] $PathConfig) {
        #TODO Add Conifg constructor
        # Should have a valid file
        $json = Get-Content -Path $PathConfig | ConvertFrom-Json

        $this.LogPath = $json.PSLog.Csv.LogPath
        $this.Levels = $json.PSLog.Csv.Levels
        $this.MessageTemplate = $json.PSLog.Csv.MesageTemplate
    }

    [string] $LogPath
    [string] $MessageTemplate
    [string[]] $Levels

    # Private method to tell if we can use this endpoint for processing
    [bool] _isValidEndPoint() {

        if ( [System.String]::IsNullOrEmpty($this.LogPath) -eq $false -and 
             [System.String]::IsNullOrEmpty($this.MessageTemplate) -eq $false ) {
            return $true
        }

        return $false
    }

    # This is a generic class we will use to write the CSV Log
    [void] Write( [string] $Message, [string] $Level, [string] $CallingFile, [int] $LineNumber ) {

        $Valid = $false
        foreach ( $l in $this.Levels) {
            if ( $l -eq $Level) {
                $Valid = $true
            }
        }

        # check the results to find out if we can process this message
        if ( $Valid -eq $false ) {
            # if we got a false, cancle out of this method
            continue
        }

        # Confirm that we can find the log file.
        $info = [System.IO.FileInfo]::new($this.LogPath)
        if ( $info.Exists -eq $false ) {
            # Generate where we ae going to store logging
            New-Item -Path $info.Directory -Name $info.Name -ItemType "file" | Out-Null
            
            # Get the correct header that is needed 
            $header = $this.ReturnHeader()

            # Add that as the first line of the file.
            Add-Content -Path $this.LogPath -Value $header
        }

        # Check for file lock status
        $isFileLocked = $this.CheckFileLock()

        while ( $isFileLocked -eq $true ) {
            # just keep checking
            #TODO Add more logic here?
        }

        # Convert the Message Template to a csv message to load into the file
        $msg = $this.ConvertToMessageTemplate($Level, $Message, $LineNumber, $CallingFile)

        Add-Content -Path $this.LogPath -Value $msg

    }

    # Use this to check if we the log file is currently avilable to write to.
    [bool] CheckFileLock() {
        if ( [System.IO.File]::Exists($this.LogPath) -eq $false ) {
            throw "Unable to check File Lock because file was not found on disk."
        }

        try {
            $Info = [System.IO.FileInfo]::new($this.LogPath)
            # Test with Streams
            [System.IO.FileStream] $FileOpen = $Info.Open(
                # Check to see if the File is open
                [System.IO.FileMode]::Open,
                # Check to see if we have ReadWrite to the file
                [System.IO.FileAccess]::ReadWrite,
                # Check to see if the file is accesed by a share.
                [System.IO.FileShare]::None) 
                
                if ( $FileOpen ) {
                     $FileOpen.Close()
                }
                return $false
        }
        catch {
            # File is locked currently.
            # Wonder if we get the process that locked it
            return $true
        }
    }

    # This is used to return the header string for new csv files
    [string] ReturnHeader() {
        $s = $this.MessageTemplate

        if( $s.Contains("#Level#") -eq $true ){
            $s = $s.Replace("#Level#", "Level")
        }

        if( $s.Contains("#DateTime#") -eq $true ){
            $s = $s.Replace("#DateTime#", "DateTime")
        }

        if( $s.Contains("#Message#") -eq $true ){
            $s = $s.Replace("#Message#", "Message")
        }

        if( $s.Contains("#LineNumber#") -eq $true){
            $s = $s.Replace("#LineNumber#", "LineNumber")
        }

        if( $s.Contains("#File#") -eq $true){
            $s = $s.Replace("#File#", "File")
        }

        return $s
    } 
}