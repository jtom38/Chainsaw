
# This class contains the settings needed to write messages to the console.
class ConsoleSettings : TemplateConverter {
    
    ConsoleSettings( [String] $MessageTemplate, [String[]] $Levels) {
        $this.Levels = $Levels
        $this.MessageTemplate = $MessageTemplate
    }
    
    ConsoleSettings( [string] $PathConfig ) {

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

        $this.MessageTemplate = $json.PSLog.Console.MesageTemplate
        $this.Levels = $json.PSLog.Console.Levels

    }

    # This defines the template we will use to format our messages
    [string] $MessageTemplate
    [string[]] $Levels 

    [bool] _isEndPointValid() {

        if ( [System.String]::IsNullOrEmpty($this.MessageTemplate) -eq $false) {
            return $true
        }

        return $false
    }

    [void] Write( [string] $Message, [string] $Level, [string] $CallingFile, [int] $LineNumber ) {
        
        $matchFound = $false
        foreach ( $l in $this.Levels) {
            if ( $l -eq $Level) {
                $matchFound = $true
            }
        }

        if ( $matchFound -eq $false ) {
            # We have a message that is not valid for Console, fail out
            continue
        }
        
        #$msg = $this.FormatMessage($Message, $Level, $CallingFile, $LineNumber)
        $msg = $this.ConvertToMessageTemplate($Level, $Message, $LineNumber, $CallingFile)

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

    [string] FormatMessage( [string] $Message, [string] $Level, [string] $CallingFile, [int] $LineNumber ) {
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

}