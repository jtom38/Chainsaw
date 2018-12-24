
# This class contains the settings needed to write messages to the console.
class ConsoleSettings {
    
    Console( [String] $Template) {
        if ( [System.String]::IsNullOrEmpty($Template) -eq $true ) {
            throw 'Template: was null'
        } 

        $this.Template = $Template
    }
    
    Console( [string] $PathConfig ) {

        if ( [System.String]::IsNullOrEmpty($PathConfig) -eq $true ) {
            Throw 'PathConfig: was null'
        }

        if ( [System.IO.File]::Exists($PathConfig) -eq $false ) {
            Throw "PathConfig: $($PathConfig) was not found on disk."
        }

        if ( [System.IO.FileInfo]::new($PathConfig).Extension.Equals("json") -eq $false ) {
            Throw "PathConfig: is not a json file"
        }

        # Should have a valid file
        $json = Get-Content -Path $PathConfig | ConvertFrom-Json

        $this.Template = $json.PSLog.Console.Template

    }

    # This defines the template we will use to format our messages
    [string] $Template

    [void] Write( [string] $Message, [string] $Level, [string] $CallingFile, [int] $LineNumber ) {
        $msg = $this.FormatMessage($Message, $Level, $CallingFile, $LineNumber)

        # Write to Console
        [System.Console]::ForegroundColor = [ConsoleColor]::

        switch ( $Level.ToLower() ) {
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


        Write-Host $msg
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