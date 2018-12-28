
class EventLogSettings : TemplateConverter {
    
    EventLogSettings([string[]] $Levels, [string] $LogName, [string] $Source) {
        $this.Levels = $Levels
        $this.LogName = $LogName
        $this.Source = Source
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

        $json = Get-Content -Path $PathConfig | ConvertFrom-Json
        $this.Levels = $json.PSLog.EventViewer.Levels
        $this.LogName = $json.PSLog.EventViewer.LogName
        $this.Source = $json.PSLog.EventViewer.Source
    }

    [string[]] $Levels
    [string] $LogName
    [string] $Source

    [bool] _isEndPointValid(){

        if ( [System.String]::IsNullOrEmpty($this.Levels) -eq $false -and
             [System.String]::IsNullOrEmpty($this.LogName) -eq $false -and 
             [System.String]::IsNullOrEmpty($this.Source) -eq $false) {
                 return $true
             }
        return $false
    }

    [void] Write( [string] $Message, [string] $Level ) {

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

        # We are going to write to a custom source 

        Write-EventLog -LogName $this.LogName -Source $this.Source -EntryType $Level
    }

}