
class PSLogEventLog {
    
    PSLogEventLog() {
        
    }

    PSLogEventLog([string[]] $Levels, [string] $LogName, [string] $Source) {
        $this.Levels = $Levels
        $this.LogName = $LogName
        $this.Source = $Source
    }

    PSLogEventLog([string] $PathConfig ) {

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
        $this.Levels = $json.PSLog.EventLog.Levels
        $this.LogName = $json.PSLog.EventLog.LogName
        $this.Source = $json.PSLog.EventLog.Source
        $this._SourceExists()
    }

    [string[]] $Levels
    [string] $LogName
    [string] $Source

    [void] Write([string] $Level, [string] $Message ) {
        # check the results to find out if we can process this message
        if ( $this._IsMessageValid($Level) -eq $false ) {
            # if we got a false, cancle out of this method
            return 
        }

        if ( $this._SourceExists() -eq $false ) {
            # Unable to Find/Create the log storage.  Throw a message to Console.
            Write-Error -Message "Unable to use EventViewer EndPoint.  Please run this script as an Administrator or create the log as Administrator and try again."
            continue
        }

        $event = [System.Diagnostics.EventLog]::new()
        $event.Source = $this.Source
        $event.Log = $this.LogName

        # We have the log generated
        switch ($Level.ToLower() ) {
            "information" {
                $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Information)
            }
            "warning" {
                $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Warning)
            }
            "error" {
                $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Error)
            }
            "debug" {
                $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Information)
            }
            Default {}
        }
        
    }

    [void] Write([string] $Level, [string] $Message, [int] $ErrorCode) {
        # check the results to find out if we can process this message
        if ( $this._IsMessageValid($Level) -eq $false ) {
            # if we got a false, cancle out of this method
            return 
        }

        if ( $this._SourceExists() -eq $false ) {
            # Unable to Find/Create the log storage.  Throw a message to Console.
            Write-Error -Message "Unable to use EventViewer EndPoint.  Please run this script as an Administrator or create the log as Administrator and try again."
            continue
        }

        $event = [System.Diagnostics.EventLog]::new()
        $event.Source = $this.Source
        $event.Log = $this.LogName

        # We have the log generated
        switch ($Level.ToLower() ) {
            "information" {
                $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Information, $ErrorCode)
            }
            "warning" {
                $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Warning, $ErrorCode)
            }
            "error" {
                $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Error, $ErrorCode)
            }
            "debug" {
                $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Information), $ErrorCode
            }
            Default {}
        }
    }

    [void] Write([string] $Level, [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $CallingLine) {
        # check the results to find out if we can process this message
        if ( $this._IsMessageValid($Level) -eq $false ) {
            # if we got a false, cancle out of this method
            continue 
        }

        if ( $this._SourceExists() -eq $false ) {
            # Unable to Find/Create the log storage.  Throw a message to Console.
            Write-Error -Message "Unable to use EventViewer EndPoint.  Please run this script as an Administrator or create the log as Administrator and try again."
            continue
        }

        $event = [System.Diagnostics.EventLog]::new()
        $event.Source = $this.Source
        $event.Log = $this.LogName

        # We have the log generated
        switch ($Level.ToLower() ) {
            "information" {
                $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Information, $ErrorCode)
            }
            "warning" {
                $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Warning, $ErrorCode)
            }
            "error" {
                $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Error, $ErrorCode)
            }
            "debug" {
                $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Information, $ErrorCode)
            }
            Default {}
        }
    }

    # This is used to build the log.
    # Administrator permissions are required to run this method.
    [bool] InitializeLog() {
        <#
        try {
            [System.Diagnostics.EventLog]::SourceExists($this.Source)
            Write-Host "Log was already created."
            continue
        }
        catch {
            # We did not find the log, we are going to try to create it.
        }
        #>

        try {
            [System.Diagnostics.EventLog]::CreateEventSource($this.Source, $this.LogName)

            $event = [System.Diagnostics.EventLog]::new()
            $event.Source = $this.Source
            $event.Log = $this.LogName
            $Message = "New log was initialized by $ENV:Username"
            $event.WriteEntry($Message, [System.Diagnostics.EventLogEntryType]::Information, 1)
            Write-Host $Message
            return $true
        }
        catch {
            throw "Failed to generate the log.  Are you running as Administrator?"
            return $false
        }
    }

    [bool] _isEndPointValid(){

        if ( [System.String]::IsNullOrEmpty($this.Levels) -eq $false -and
             [System.String]::IsNullOrEmpty($this.LogName) -eq $false -and 
             [System.String]::IsNullOrEmpty($this.Source) -eq $false) {
                 return $true
             }
        return $false
    }

    [bool] _IsMessageValid([string] $Level) {

        $Valid = $false
        foreach ( $l in $this.Levels) {
            if ( $l -eq $Level) {
                $Valid = $true
            }
        }
        return $Valid

    }

    [bool] _SourceExists(){
        # We are going to write to a custom source 
        try {
            [System.Diagnostics.EventLog]::SourceExists($this.Source)
            return $true
        }
        catch {
            #need to make the log
            try {
                [System.Diagnostics.EventLog]::CreateEventSource($this.Source, $this.LogName)
                return $true
            }
            catch {
                Write-Host "Unable to create the log source.  Please try again as an administrator."
                return $false
            }
        }
        return $false
    }

    [string] _BuildMessage([string] $Message, [string] $CallingFile, [int] $CallingLine = 0) {

        $msg = ""

        if ( [System.String]::IsNullOrEmpty($Message) -eq $false ) {
            $m = $Message + "\r" 
            $msg += $m
        }

        if ( [System.String]::IsNullOrEmpty($CallingFile) -eq $false ) {
            $msg += "Calling File: $CallingFile \r"
        }

        if ( $CallingLine.Equals(0) -eq $false ) {
            $msg += "Calling Line: $CallingLine \r"
        }

        return $msg
    }
}