
# This is the entry point for PsLog.  
# From here we can extend into other classes.
class PsLog {
  
    PsLog(){
        . .\PsLogCsv\Classes\Csv.ps1
    }

    # Thought, Use this as a method to define what is enabled  
    # Region Enable functions
    [Csv] $CsvConfig
    [Console] $ConsoleConfig

    [bool] EnableCsv( [Csv] $Config ) {
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

    [bool] EnableConsole( [Console] $Config) {


        $this.ConsoleConfig = $Config
        return $true
    }
    # End Region
    
    # Region Logging Methods

    [void] Info( [string] $Message, [string] $Level, [string] $CallingFile, [int] $LineNumber) {
        
        if ($this.CsvConfig.)
    }

    [void] Error() {

    }

    # End Region
}