
class CsvSettings {
    
    CsvSettings([string] $LogPath, [string] $MesageTemplate, [string[]] $Levels) {
        $this.LogPath = $LogPath
        $this.MesageTemplate = $MesageTemplate
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

    [PSObject] $Config

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

        foreach ( $i in $this.Levels ) {
            if ( $i -eq $Level) {
                # We have a match!
            }
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
        #$lock = [FileLock]::new()


        Add-Content -Path $this.LogPath -Value $Message

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


# This class contains the settings needed to write messages to the console.
class ConsoleSettings {
    
    ConsoleSettings( [String] $MesageTemplate, [String[]] $Levels) {
        $this.Levels = $Levels
        $this.MesageTemplate = $MesageTemplate
    }
    
    ConsoleSettings( [string] $PathConfig ) {

        if ( [System.String]::IsNullOrEmpty($PathConfig) -eq $true ) {
            Throw 'PathConfig: was null'
        }

        if ( [System.IO.File]::Exists($PathConfig) -eq $false ) {
            Throw "PathConfig: $($PathConfig) was not found on disk."
        }

        if ( [System.IO.FileInfo]::new($PathConfig).Extension.Equals("json") -eq $false ) {
            Throw "PathConfig: is not a json file"
        }

        # Should have a valid file
        $json = Get-Content -Path $PathConfig | ConvertFrom-Json

        $this.MesageTemplate = $json.PSLog.Console.MesageTemplate
        $this.Levels = $json.PSLog.Console.Levels

    }

    # This defines the template we will use to format our messages
    [string] $MesageTemplate
    [string[]] $Levels 

    [void] Write( [string] $Message, [string] $Level, [string] $CallingFile, [int] $LineNumber ) {
        $msg = $this.FormatMessage($Message, $Level, $CallingFile, $LineNumber)

        # Write to Console
        [System.Console]::ForegroundColor = [ConsoleColor]::

        switch($Level.ToLower()) 
        {
            error { [System.Console]::ForegroundColor = [ConsoleColor]::Red; Break }
            information { [System.Console]::ForegroundColor = [ConsoleColor]::Green; Break }
            info { [System.Console]::ForegroundColor = [ConsoleColor]::Green; Break }
            warning { [System.Console]::ForegroundColor = [ConsoleColor]::Yellow; Break}
            debug { [System.Console]::ForegroundColor = [System.ConsoleColor]::Magenta; Break; }
            default { [System.Console]::ForegroundColor = [ConsoleColor]::White; Break }
        }
        [System.Console]::WriteLine($msg)

        # Set the color back to normal for messages that do not pass though the logger
        [Console]::ForegroundColor = [ConsoleColor]::White
        
        Write-Host $msg
    }

    [string] FormatMessage( [string] $Message, [string] $Level, [string] $CallingFile, [int] $LineNumber ) {
        $s = $this.Template
        #$s = "[#DateTime#] [#Level#] #Message#"
        
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

# This is the entry point for PsLog.  
# From here we can extend into other classes.
class PsLog {
  
    PsLog() {
        # Default is false
        $this.StorageAllMessagesSent = $false
    }

    # If you want to store all the messages sent to the logger so you can call them later update this to true
    [bool] $StorageAllMessagesSent

    # Thought, Use this as a method to define what is enabled  
    # Region Enable functions
    [CsvSettings] $CsvConfig
    [ConsoleSettings] $ConsoleConfig


    # End Region
    
    # Region Logging Methods

    [void] Info( [string] $Message, [string] $CallingFile, [int] $LineNumber) {
        
        if ( $this.CsvConfig._isValidEndPoint() -eq $false ) {

        }
    }

    [void] Error() {
        throw not finished yet
    }

    [void] warning () {
        throw Not finished yes
    }

    # End Region

}