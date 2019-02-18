# Generated 02/18/2019 08:59:08

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
    }

    Chainsaw( [string] $PathConfig ){
        
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

    [void] Error( [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber) {
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

    [void] Warning( [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber) {
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

    [void] Debug( [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber) {
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

<#
.Synopsis
This target will send the log message to the Console window.

.Description
Config Template
{
    "Chainsaw" : {
        "Console" : {
            "Levels" : [
                "Information",
                "Warning",
                "Error",
                "Debug"
            ],
            "MessageTemplate" : "[#DateTime#] [#Level#] #Message#"
        }
    }
}

.Example
$Logger = [Chainsaw]::new()
$Logger.ConsoleConfig = [ChainsawConsole]::new(".\config.json")

$Logger = [Chainsaw]::new()
$console = [ChainsawConsole]::new()
$console.LogPath = ".\log.csv"
$console.MessageTemplate = "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"
$console.Levels = @("Information", "Warning", "Error", "Debug")
$Logger.ConsoleConfig = $console

$Logger = [Chainsaw]::new()
$Logger.ConsoleConfig = [ChainsawConsole]::new($LogPath, $MessageTemplate, $Levels)

#>
class ChainsawConsole {
    
    ChainsawConsole() {
        
    }

    ChainsawConsole( [String] $MessageTemplate, [String[]] $Levels) {
        $this.Levels = $Levels
        $this.MessageTemplate = $MessageTemplate
    }
    
    ChainsawConsole( [string] $PathConfig ) {

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

        # Should have a valid file
        $json = Get-Content -Path $PathConfig | ConvertFrom-Json

        $this.MessageTemplate = $json.Chainsaw.Console.MessageTemplate
        $this.Levels = $json.Chainsaw.Console.Levels
    }

    # Region Define public properties
    # This defines the template we will use to format our messages
    [string] $MessageTemplate
    [string[]] $Levels 
    # Region End

    [bool] _isEndPointValid() {

        if ( [System.String]::IsNullOrEmpty($this.MessageTemplate) -eq $false) {
            return $true
        }

        return $false
    }

    [void] Write([string] $Level, [string] $Message) {

        if ( $this._IsMessageValid($Level) -eq $false ) {
            # if we got a false, cancle out of this method
            continue 
        }
        
        #$msg = $this.FormatMessage($Message, $Level, $CallingFile, $LineNumber)
        $convert = [TemplateConverter]::new($this.MessageTemplate)
        $msg = $convert.ConvertToMessageTemplate($Level, $Message)
        #$msg = $this.ConvertToMessageTemplate($Level, $Message, $LineNumber, $CallingFile)

        switch($Level.ToLower()) 
        {
            error { [System.Console]::ForegroundColor = [ConsoleColor]::Red; Break }
            information { [System.Console]::ForegroundColor = [ConsoleColor]::Green; Break }
            info { [System.Console]::ForegroundColor = [ConsoleColor]::Green; Break }
            warning { [System.Console]::ForegroundColor = [ConsoleColor]::Yellow; Break}
            debug { [System.Console]::ForegroundColor = [System.ConsoleColor]::Magenta; Break; }
            default { [System.Console]::ForegroundColor = [ConsoleColor]::White; Break }
        }
        [System.Console]::WriteLine($msg)

        # Set the color back to normal for messages that do not pass though the logger
        [Console]::ForegroundColor = [ConsoleColor]::White
    }

    [void] Write([string] $Level, [string] $Message, [int] $ErrorCode) {
        
        if ( $this._IsMessageValid($Level) -eq $false ) {
            # if we got a false, cancle out of this method
            continue 
        }
        
        #$msg = $this.FormatMessage($Message, $Level, $CallingFile, $LineNumber)
        $convert = [TemplateConverter]::new($this.MessageTemplate)
        $msg = $convert.ConvertToMessageTemplate($Level, $Message, $ErrorCode)
        #$msg = $this.ConvertToMessageTemplate($Level, $Message, $LineNumber, $CallingFile)

        switch($Level.ToLower()) 
        {
            error { [System.Console]::ForegroundColor = [ConsoleColor]::Red; Break }
            information { [System.Console]::ForegroundColor = [ConsoleColor]::Green; Break }
            info { [System.Console]::ForegroundColor = [ConsoleColor]::Green; Break }
            warning { [System.Console]::ForegroundColor = [ConsoleColor]::Yellow; Break}
            debug { [System.Console]::ForegroundColor = [System.ConsoleColor]::Magenta; Break; }
            default { [System.Console]::ForegroundColor = [ConsoleColor]::White; Break }
        }
        [System.Console]::WriteLine($msg)

        # Set the color back to normal for messages that do not pass though the logger
        [Console]::ForegroundColor = [ConsoleColor]::White
    }

    [void] Write([string] $Level, [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber ) {

        if ( $this._IsMessageValid($Level) -eq $false ) {
            # if we got a false, cancle out of this method
            continue 
        }
        
        #$msg = $this.FormatMessage($Message, $Level, $CallingFile, $LineNumber)
        $convert = [TemplateConverter]::new($this.MessageTemplate)
        $msg = $convert.ConvertToMessageTemplate($Level, $Message, $ErrorCode, $CallingFile, $LineNumber)
        #$msg = $this.ConvertToMessageTemplate($Level, $Message, $LineNumber, $CallingFile)

        switch($Level.ToLower()) 
        {
            error { [System.Console]::ForegroundColor = [ConsoleColor]::Red; Break }
            information { [System.Console]::ForegroundColor = [ConsoleColor]::Green; Break }
            info { [System.Console]::ForegroundColor = [ConsoleColor]::Green; Break }
            warning { [System.Console]::ForegroundColor = [ConsoleColor]::Yellow; Break}
            debug { [System.Console]::ForegroundColor = [System.ConsoleColor]::Magenta; Break; }
            default { [System.Console]::ForegroundColor = [ConsoleColor]::White; Break }
        }
        [System.Console]::WriteLine($msg)

        # Set the color back to normal for messages that do not pass though the logger
        [Console]::ForegroundColor = [ConsoleColor]::White
    }

    [string] _FormatMessage( [string] $Message, [string] $Level, [string] $CallingFile, [int] $LineNumber ) {
        $s = $this.Template
        #$s = "[#DateTime#] [#Level#] #Message#"
        
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

    [bool] _IsMessageValid([string] $Level) {

        $Valid = $false
        foreach ( $l in $this.Levels) {
            if ( $l -eq $Level) {
                $Valid = $true
            }
        }
        return $Valid

    }

}
<#
.Synopsis
This target will write logs to a defined CSV file

.Description
Config Tempalte:
{
    "Chainsaw" : {
        "CSV" : {
            "Levels" : [
                "Information",
                "Warning",
                "Error",
                "Debug"
            ],
            "LogPath" : ".\\log.csv",
            "MessageTemplate" : "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"
        }
    }
}

.Example
$LogPath = ".\log.csv"
$MessageTemplate = "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"
$Levels = @("Information", "Warning", "Error", "Debug")

$csv = [ChainsawCsv]::new()
$csv.LogPath = $LogPath
$csv.MessageTemplate = $MessageTemplate
$csv.Levels = $Levels

[ChainsawCsv]::new($LogPath, $MessageTemplate, $Levels)

[ChainsawCsv]::new(".\config.json")

#>
class ChainsawCsv {
    
    ChainsawCsv() {
        
    }

    ChainsawCsv([string] $LogPath, [string] $MessageTemplate, [string[]] $Levels) {
        $this.LogPath = $LogPath
        $this.MessageTemplate = $MessageTemplate
        $this.Levels = $Levels
    }

    ChainsawCsv([string] $PathConfig) {
        # Should have a valid file
        $json = Get-Content -Path $PathConfig | ConvertFrom-Json

        $this.LogPath = $json.Chainsaw.Csv.LogPath
        $this.Levels = $json.Chainsaw.Csv.Levels
        $this.MessageTemplate = $json.Chainsaw.Csv.MessageTemplate
    }

    [string] $LogPath
    [string] $MessageTemplate
    [string[]] $Levels

    # Private method to tell if we can use this endpoint for processing
    [bool] _isValidEndPoint() {

        if ( [System.String]::IsNullOrEmpty($this.LogPath) -eq $false -and 
             [System.String]::IsNullOrEmpty($this.MessageTemplate) -eq $false ) {
            return $true
        }

        return $false
    }

    # This is a generic class we will use to write the CSV Log
    [void] Write( [string] $Level, [string] $Message) {
        if ( $this._IsMessageValid($Level) -eq $false) {
            continue
        }

        # Confirm that we can find the log file.
        $this._GenerateCsvIfMissing()

        # Check for file lock status
        $isFileLocked = $this.CheckFileLock()

        while ( $isFileLocked -eq $true ) {
            # just keep checking
            #TODO Add more logic here?
        }

        # Convert the Message Template to a csv message to load into the file
        $convert = [TemplateConverter]::new($this.MessageTemplate)
        $msg = $convert.ConvertToMessageTemplate($Level, $Message)
        #$msg = $this.ConvertToMessageTemplate($Level, $Message)

        Add-Content -Path $this.LogPath -Value $msg
    }

    [void] Write( [string] $Level, [string] $Message, [int] $ErrorCode ) {
        if ( $this._IsMessageValid($Level) -eq $false) {
            continue
        }

        # Confirm that we can find the log file.
        $this._GenerateCsvIfMissing()

        # Check for file lock status
        $isFileLocked = $this.CheckFileLock()

        while ( $isFileLocked -eq $true ) {
            # just keep checking
            #TODO Add more logic here?
        }

        # Convert the Message Template to a csv message to load into the file
        $convert = [TemplateConverter]::new($this.MessageTemplate)
        $msg = $convert.ConvertToMessageTemplate($Level, $Message, $ErrorCode)

        Add-Content -Path $this.LogPath -Value $msg
    }

    [void] Write( [string] $Level, [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber ) {

        if ( $this._IsMessageValid($Level) -eq $false) {
            continue
        }

        # Confirm that we can find the log file.
        $this._GenerateCsvIfMissing()

        # Check for file lock status
        $isFileLocked = $this.CheckFileLock()

        while ( $isFileLocked -eq $true ) {
            # just keep checking
            #TODO Add more logic here?
        }

        # Convert the Message Template to a csv message to load into the file
        $convert = [TemplateConverter]::new($this.MessageTemplate)
        $msg = $convert.ConvertToMessageTemplate($Level, $Message, $ErrorCode, $CallingFile, $LineNumber )

        Add-Content -Path $this.LogPath -Value $msg

    }

    # Use this to check if we the log file is currently avilable to write to.
    hidden [bool] CheckFileLock() {
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
    hidden [string] _ReturnHeader() {
        $s = $this.MessageTemplate

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

        if( $s.Contains("#CallingFile#") -eq $true){
            $s = $s.Replace("#CallingFile#", "CallingFile")
        }

        if ( $s.Contains("#ErrorCode#") -eq $true) {
            $s = $s.Replace("#ErrorCode#", "ErrorCode")
        }

        return $s
    } 

    hidden [void] _GenerateCsvIfMissing() {
        $info = [System.IO.FileInfo]::new($this.LogPath)
        if ( $info.Exists -eq $false ) {
            # Generate where we ae going to store logging
            New-Item -Path $info.Directory -Name $info.Name -ItemType "file" | Out-Null
            
            # Get the correct header that is needed 
            $header = $this._ReturnHeader()

            # Add that as the first line of the file.
            Add-Content -Path $this.LogPath -Value $header
        }
    }

    hidden [bool] _IsMessageValid([string] $Level) {
        $Valid = $false
        foreach ( $l in $this.Levels) {
            if ( $l -eq $Level) {
                $Valid = $true
            }
        }

        # check the results to find out if we can process this message
        if ( $Valid -eq $false ) {
            # if we got a false, cancle out of this method
            return $false
        }
        return $true
    }
}
<#
.Synopsis
This target will write to the Windows Event Log.

.Description
Config Template:
{
    "Chainsaw" : {
        "EventLog" : {
            "Levels" : [
                "Warning",
                "Error"
            ],
            "LogName" : "Application",
            "Source" : "Chainsaw"
        }
    }
}

In order to use this target you will need to initalize the log as an administrator ahead of time.  To do so 


.Example
$LogName = "Application"
$Source = "Chainsaw"
$Levels = @("Information", "Warning", "Error", "Debug")

$eventlog = [ChainsawEventLog]::new()
$eventlog.LogName = $LogName
$eventlog.Source = $Source
$eventlog.Levels = $Levels

[ChainsawEventLog]::new($Levels, $LogName, $Source)

[ChainsawEventLog]::new(".\config.json")

#>
class ChainsawEventLog {
    
    ChainsawEventLog() {
        
    }

    ChainsawEventLog([string[]] $Levels, [string] $LogName, [string] $Source) {
        $this.Levels = $Levels
        $this.LogName = $LogName
        $this.Source = $Source
    }

    ChainsawEventLog([string] $PathConfig ) {

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
        $this.Levels = $json.Chainsaw.EventLog.Levels
        $this.LogName = $json.Chainsaw.EventLog.LogName
        $this.Source = $json.Chainsaw.EventLog.Source
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

    hidden [bool] _isEndPointValid(){

        if ( [System.String]::IsNullOrEmpty($this.Levels) -eq $false -and
             [System.String]::IsNullOrEmpty($this.LogName) -eq $false -and 
             [System.String]::IsNullOrEmpty($this.Source) -eq $false) {
                 return $true
             }
        return $false
    }

    hidden [bool] _IsMessageValid([string] $Level) {

        $Valid = $false
        foreach ( $l in $this.Levels) {
            if ( $l -eq $Level) {
                $Valid = $true
            }
        }
        return $Valid

    }

    hidden [bool] _SourceExists(){
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

    hidden [string] _BuildMessage([string] $Message, [string] $CallingFile, [int] $CallingLine = 0) {

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

class ChainsawSmtp : System.Net.Mail.SmtpClient {
    
    ChainsawSmtp() {

    }

    ChainsawSmtp([string[]] $Levels, [string] $Server, [int] $Port, [bool] $Security) {
        $this.Levels = $Levels
        $this.Server = $Server
        $this.Port = $Port
        $this.Security = $Security
    }

    ChainsawSmtp([string[]] $Levels, [string] $Server, [int] $Port, [bool] $Security, [string] $Username, [string] $Password) {
        $this.Levels = $Levels
        $this.Server = $Server
        $this.Port = $Port
        $this.Security = $Security
        $this.Username = $Username
        $this.Password = $Password

        $client = $this.BuildSmtpClient()        
    }

    [string[]] $Levels
    [string] $Server
    [int] $Port
    [bool] $Security

    [string] $Username
    [string] $Password

    [bool] _isValidEndPoint() {

        if ( [System.String]::IsNullOrEmpty($this.Server) -eq $false -and 
             [System.String]::IsNullOrEmpty($this.Port) -eq $false ) {
            return $true
        }

        return $false
    }

    # This is a generic class we will use to write the CSV Log
    [void] Write( [string] $Level, [string] $Message) {
        if ( $this._IsMessageValid($Level) -eq $false) {
            continue
        }

        $client = $this.BuildSmtpClient()
    }

    [void] BuildSmtpClient() {
        $client = [System.Net.Mail.SmtpClient]::new()
        #$client.Connect($this.Server, $this.Port, $true)

        if ( $client.IsConnected -eq $true ) {
            #return $client
        }
        else {
            throw "Unable to connect to SMTP server"
            #return $null
        }
    }

    [void] BuildMessage() {
        

    }
}

class TemplateConverter {
    
    TemplateConverter([string] $MessageTemplate){
        $this.MessageTemplate = $MessageTemplate
    }    

    [string] $MessageTemplate

    [string] ConvertToMessageTemplate([string] $Level, [string] $Message ){
        $s = $this.MessageTemplate

        if( $s.Contains("#Level#") -eq $true ){
            $s = $s.Replace("#Level#", $Level)
        }

        if( $s.Contains("#DateTime#") -eq $true ){
            $dt = [System.DateTime]::Now
            $s = $s.Replace("#DateTime#", $dt)
        }

        if( $s.Contains("#Message#") -eq $true ){
            $s = $s.Replace("#Message#", $Message)
        }

        if( $s.Contains("#LineNumber#") -eq $true){
            $s = $s.Replace("#LineNumber#", "")
        }

        if( $s.Contains("#CallingFile#") -eq $true){
            $s = $s.Replace("#CallingFile#", "")
        }

        if( $s.Contains("#ErrorCode#") -eq $true){
            $s = $s.Replace("#ErrorCode#", "")
        }
        return $s
    }

    [string] ConvertToMessageTemplate([string] $Level, [string] $Message, [int] $ErrorCode){
        $s = $this.MessageTemplate

        if( $s.Contains("#Level#") -eq $true ){
            $s = $s.Replace("#Level#", $Level)
        }

        if( $s.Contains("#DateTime#") -eq $true ){
            $dt = [System.DateTime]::Now
            $s = $s.Replace("#DateTime#", $dt)
        }

        if( $s.Contains("#Message#") -eq $true ){
            $s = $s.Replace("#Message#", $Message)
        }

        if( $s.Contains("#ErrorCode#") -eq $true ){
            $s = $s.Replace("#ErrorCode#", $ErrorCode)
        }

        if( $s.Contains("#LineNumber#") -eq $true){
            $s = $s.Replace("#LineNumber#", "")
        }

        if( $s.Contains("#CallingFile#") -eq $true){
            $s = $s.Replace("#CallingFile#", "")
        }

        if( $s.Contains("#ErrorCode#") -eq $true){
            $s = $s.Replace("#ErrorCode#", "")
        }
        return $s
    }

    [string] ConvertToMessageTemplate([string] $Level, [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber){
        $s = $this.MessageTemplate

        if( $s.Contains("#Level#") -eq $true ){
            $s = $s.Replace("#Level#", $Level)
        }

        if( $s.Contains("#DateTime#") -eq $true ){
            $dt = [System.DateTime]::Now
            $s = $s.Replace("#DateTime#", $dt)
        }

        if( $s.Contains("#Message#") -eq $true ){
            $s = $s.Replace("#Message#", $Message)
        }

        if( $s.Contains("#LineNumber#") -eq $true){
            $s = $s.Replace("#LineNumber#", $LineNumber)
        }

        if( $s.Contains("#CallingFile#") -eq $true){
            $s = $s.Replace("#CallingFile#", $CallingFile)
        }

        if( $s.Contains("#ErrorCode#") -eq $true){
            $s = $s.Replace("#ErrorCode#", $ErrorCode)
        }
        return $s
    }

}
