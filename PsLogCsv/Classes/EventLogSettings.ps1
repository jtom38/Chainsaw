
class EventLogSettings : TemplateConverter {
    
    EventLogSettings() {

    }

    EventLogSettings([string] $PathConfig ) {

        if ( [System.String]::IsNullOrEmpty($PathConfig) -eq $true ) {
            Throw 'PathConfig: was null'
        }

        if ( [System.IO.File]::Exists($PathConfig) -eq $false ) {
            Throw "PathConfig: $($PathConfig) was not found on disk."
        }

        $info = [System.IO.FileInfo]::new($PathConfig)

        if ( $info.Extension.Equals("json") -eq $true ) {
            Throw "PathConfig: is not a json file"
        }
    }

    [string[]] $Levels
    [string] $LogName

    # Defines 
    [string] $Source

    [bool] _isEndPointValid(){

    }

}