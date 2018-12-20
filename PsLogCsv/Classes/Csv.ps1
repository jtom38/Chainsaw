
class Csv {
    
    Csv([string] $LogPath, [string] $Template) {
        $this.LogPath = $LogPath
        $this.Template = $Template
    }

    [string] $LogPath
    [string] $Template

    # This is a generic class we will use to write the CSV Log
    [void] Write( [string] $Message, [string] $Level, [string] $CallingFile, [int] $LineNumber ) {


        
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
    [string] ReturnHeader([string] $CsvLogFormat) {
        $s = $CsvLogFormat

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