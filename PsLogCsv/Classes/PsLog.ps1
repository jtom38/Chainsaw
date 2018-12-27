
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
        
        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write($Message, "Information", $CallingFile, $LineNumber)
        }

        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write($Message, "Information", $CallingFile, $LineNumber)
        }
        
    }

    [void] Error([string] $Message, [string] $CallingFile, [int] $LineNumber) {
        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write($Message, "Error", $CallingFile, $LineNumber)
        }

        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write($Message, "Error", $CallingFile, $LineNumber)
        }
    }

    [void] Warning ([string] $Message, [string] $CallingFile, [int] $LineNumber) {
        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write($Message, "Warning", $CallingFile, $LineNumber)
        }

        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write($Message, "Warning", $CallingFile, $LineNumber)
        }
    }

    [void] Debug([string] $Message, [string] $CallingFile, [int] $LineNumber) {
        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write($Message, "Debug", $CallingFile, $LineNumber)
        }

        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write($Message, "Debug", $CallingFile, $LineNumber)
        }
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