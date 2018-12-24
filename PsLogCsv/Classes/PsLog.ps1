
# This is the entry point for PsLog.  
# From here we can extend into other classes.
class PsLog {
  
    PsLog(){
        # Default is false
        $this.StorageAllMessagesSent = $false
    }

    # If you want to store all the messages sent to the logger so you can call them later update this to true
    [bool] $StorageAllMessagesSent

    # Thought, Use this as a method to define what is enabled  
    # Region Enable functions
    [CsvSettings] $CsvConfig
    [ConsoleSettings] $ConsoleConfig

    [bool] EnableCsv( [CsvSettings] $Config ) {
        # Check against the class to see if we have what is needed
        
        if ( [System.String]::IsNullOrEmpty($Config.LogPath) -eq $true ) {
            # Failed
            Throw "CSV.LogPath was not configured"
        }

        if ( [System.String]::IsNullOrEmpty($Config.Template) -eq $true ) {
            Throw "CSV.Template was not configured"
        }

        $this.CsvConfig = $Config
        return $true
    }

    [bool] EnableConsole( [ConsoleSettings] $Config) {


        $this.ConsoleConfig = $Config
        return $true
    }
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