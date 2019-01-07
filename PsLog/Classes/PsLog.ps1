
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
    [PSObject] $CsvConfig
    [PSObject] $ConsoleConfig
    [PSObject] $EventLogConfig
    # End Region
    
    # Region Logging Methods

    [void] Info( [string] $Message ) {

        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write("Information", $Message)
        }
        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write("Information", $Message)
        }
    }

    [void] Info( [string] $Message, [int] $ErrorCode ) {

        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write("Information", $Message, $ErrorCode)
        }
        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write("Information", $Message, $ErrorCode)
        }
    }

    [void] Info( [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber) {
        
        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write("Information", $Message, $ErrorCode, $CallingFile, $LineNumber)
        }

        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write("Information", $Message, $ErrorCode, $CallingFile, $LineNumber)
        }
        
    }


    [void] Error( [string] $Message ) {

        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write("Error", $Message)
        }
        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write("Error", $Message)
        }
    }

    [void] Error( [string] $Message, [int] $ErrorCode ) {

        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write("Error", $Message, $ErrorCode)
        }
        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write("Error", $Message, $ErrorCode)
        }
    }

    [void] Error([string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber) {
        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write("Error", $Message, $ErrorCode, $CallingFile, $LineNumber)
        }

        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write("Error", $Message, $ErrorCode, $CallingFile, $LineNumber)
        }
    }


    [void] Warning( [string] $Message ) {

        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write("Warning", $Message)
        }
        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write("Warning", $Message)
        }
    }

    [void] Warning( [string] $Message, [int] $ErrorCode ) {

        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write("Warning", $Message, $ErrorCode)
        }
        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write("Warning", $Message, $ErrorCode)
        }
    }

    [void] Warning ([string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber) {
        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write("Warning", $Message, $ErrorCode, $CallingFile, $LineNumber)
        }

        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write("Warning", $Message, $ErrorCode, $CallingFile, $LineNumber)
        }
    }


    [void] Debug( [string] $Message ) {

        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write("Debug", $Message)
        }
        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write("Debug", $Message)
        }
    }

    [void] Debug( [string] $Message, [int] $ErrorCode ) {

        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write("Debug", $Message, $ErrorCode)
        }
        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write("Debug", $Message, $ErrorCode)
        }
    }

    [void] Debug([string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber) {
        if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
            $this.CsvConfig.Write("Debug", $Message, $ErrorCode, $CallingFile, $LineNumber)
        }

        if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
            $this.ConsoleConfig.Write("Debug", $Message, $ErrorCode, $CallingFile, $LineNumber)
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