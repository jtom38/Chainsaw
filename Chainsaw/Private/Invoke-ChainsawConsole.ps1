

function Invoke-ChainsawConsole {
    [cmdletbinding()]
    param (
        [string] $Level,
        [string] $Message,
        [int] $ErrorCode,
        [string] $CallingFile,
        [int] $LineNumber,
        [psobject] $Exception
    )
 
    Process {

        $hash = Get-ChainsawConfig -Console
        
        # If we have an Exception extract the message and replace our message
        if( $Exception -ne $null){
            $Message = $Exception.TargetObject
        }

        $Msg = Format-ChainsawMessage -Template $hash.MessageTemplate `
            -Message $Message `
            -Level $Level `
            -CallingFile $CallingFile `
            -LineNumber $LineNumber `
            -ErrorCode $ErrorCode

        switch($Level.ToLower()) 
        {
            emergency { [System.Console]::ForegroundColor = [System.ConsoleColor]::DarkRed; break}
            alert {[System.Console]::ForegroundColor = [ConsoleColor]::DarkYellow; Break }
            critical {[System.Console]::ForegroundColor = [ConsoleColor]::DarkMagenta ; Break}
            error { [System.Console]::ForegroundColor = [ConsoleColor]::Red; Break }
            warning { [System.Console]::ForegroundColor = [ConsoleColor]::Yellow; Break}
            notice { [System.Console]::ForegroundColor = [ConsoleColor]::Blue; Break}
            info { [System.Console]::ForegroundColor = [ConsoleColor]::Green; Break }
            debug { [System.Console]::ForegroundColor = [System.ConsoleColor]::Magenta; Break; }
            default { [System.Console]::ForegroundColor = [ConsoleColor]::White; Break }
        }
        [System.Console]::WriteLine($Msg)

        # Set the color back to normal for messages that do not pass though the logger
        [Console]::ForegroundColor = [ConsoleColor]::White

    }
}