
# This class contains the settings needed to write messages to the console.
class PSLogConsole {
    
    PSLogConsole() {
        
    }

    PSLogConsole( [String] $MessageTemplate, [String[]] $Levels) {
        $this.Levels = $Levels
        $this.MessageTemplate = $MessageTemplate
    }
    
    PSLogConsole( [string] $PathConfig ) {

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

        $this.MessageTemplate = $json.PSLog.Console.MessageTemplate
        $this.Levels = $json.PSLog.Console.Levels
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