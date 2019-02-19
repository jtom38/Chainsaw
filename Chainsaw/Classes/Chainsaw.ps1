
<#
.Synopsis
This class is the primary management point for logging.  Once you have this class active you will want to enable your targets.  This class will not enable targets for you.

.Description
Once the targets are active use the methods from Chainsaw to write your messages to the desired Targets.

.Example
$Logger = [Chainsaw]::new()
$Logger.Info()

#>
class Chainsaw {
  
    Chainsaw() {
        # Default is false
        $this.StorageAllMessagesSent = $false
        $this.CsvConfig = [ChainsawCsv]::new()
        $this.ConsoleConfig = [ChainsawConsole]::new()
        $this.EventLogConfig = [ChainsawEventLog]::new()

    }

    Chainsaw( [string] $PathConfig ){
        $this.StorageAllMessagesSent = $false
        $this.CsvConfig = [ChainsawCsv]::new()
        $this.ConsoleConfig = [ChainsawConsole]::new()
        $this.EventLogConfig = [ChainsawEventLog]::new()
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

    ###
    [void] Info( [string] $Message ) {
        $this.CsvConfig.Write("Information", $Message)
    }

    [void] Info( [string] $Message, [int] $ErrorCode ) {
        $this.CsvConfig.Write("Information", $Message, $ErrorCode)
    }

    [void] Info( [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber) {
        $this.CsvConfig.Write("Information", $Message, $ErrorCode, $CallingFile, $LineNumber)
    }


    [void] Error( [string] $Message ) {
        $this.CsvConfig.Write("Error", $Message)
    }

    [void] Error( [string] $Message, [int] $ErrorCode ) {
        $this.CsvConfig.Write("Error", $Message, $ErrorCode)
    }

    [void] Error( [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber) {        
        $this.CsvConfig.Write("Error", $Message, $ErrorCode, $CallingFile, $LineNumber)
    }


    [void] Warning( [string] $Message ) {
        $this.Write("Warning", $Message)
    }

    [void] Warning( [string] $Message, [int] $ErrorCode ) {
        $this.Write("Warning", $Message, $ErrorCode)
    }

    [void] Warning( [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber) {
        $this.Write("Warning", $Message, $ErrorCode, $CallingFile, $LineNumber)
    }


    [void] Debug( [string] $Message ) {
        $this.Write("Debug", $Message)
    }

    [void] Debug( [string] $Message, [int] $ErrorCode ) {
        $this.Write("Debug", $Message, $ErrorCode)
    }

    [void] Debug( [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber) {
        $this.Write("Debug", $Message, $ErrorCode, $CallingFile, $LineNumber)
    }

    hidden [void] Write( [string] $Level, [string] $Message ) {

        try{
            if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
                $this.CsvConfig.Write($Level, $Message)
            }
        }
        catch{ }

        try{
            if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
                $this.ConsoleConfig.Write($Level, $Message)
            }
        }
        catch{ }

        try{
            if ( $this.EventLogConfig._isEndPointValid() -eq $true ) {
                $this.EventLogConfig.Write($Level, $Message)
            }
        }
        catch{ }

    }

    hidden [void] Write( [string] $Level, [string] $Message, [int] $ErrorCode ) {

        try{
            if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
                $this.CsvConfig.Write($Level, $Message, $ErrorCode)
            }
        }
        catch{ }
        
        try{
            if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
                $this.ConsoleConfig.Write($Level, $Message, $ErrorCode)
            }
        }
        catch{ }

        try{
            if ( $this.EventLogConfig._isEndPointValid() -eq $true ) {
                $this.EventLogConfig.Write($Level, $Message, $ErrorCode)
            }
        }
        catch{ }
        
    }

    hidden [void] Write( [string] $Level, [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber) {
        try{
            if ( $this.CsvConfig._isValidEndPoint() -eq $true ) {
                $this.CsvConfig.Write($Level, $Message, $ErrorCode, $CallingFile, $LineNumber)
            }
        }
        catch{ }
        
        try{
            if ( $this.ConsoleConfig._isEndPointValid() -eq $true ) {
                $this.ConsoleConfig.Write($Level, $Message, $ErrorCode, $CallingFile, $LineNumber)
            }
        }
        catch{ }

        try{
            if ( $this.EventLogConfig._isEndPointValid() -eq $true ) {
                $this.EventLogConfig.Write($Level, $Message, $ErrorCode, $CallingFile, $LineNumber)
            }
        }
        catch{ }
        
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