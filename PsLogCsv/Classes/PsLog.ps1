
# This is the entry point for PsLog.  
# From here we can extend into other classes.
class PsLog {
  
    PsLog() {
        # Import the endpoint modules
        


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
        
        if ( $this.CsvConfig._isValidEndPoint("Information") -eq $false ) {
            continue
        }

        # Write the message
    }

    [void] Error() {
        throw not finished yet
    }

    [void] warning () {
        throw Not finished yes
    }

    # End Region

    [int] GetCurrentLineNumber() {
        return $MyInvocation.ScriptLineNumber
    }

    [string] GetCurrentFileName() {
        $info = [System.IO.FileInfo]::new($MyInvocation.ScriptName)
        return $info.Name
    }
}