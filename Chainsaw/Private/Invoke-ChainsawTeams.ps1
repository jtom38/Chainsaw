

function Invoke-ChainsawTeams {
    param (
        [string] $Level,
        [string] $Message,
        [int] $ErrorCode,
        [string] $CallingFile,
        [int] $LineNumber
    )
    
    Process{
        # Get the config for easy access
        $hash = Get-ChainsawConfig -Teams

        [Object[]] $facts = @()

        $f2 = New-TeamsFact -Name 'Message:' -Value $Message
        $facts += $f2

        $f1 = New-TeamsFact -Name 'Message Level:' -Value $Level
        $facts += $f1

        if( [string]::IsNullOrEmpty($CallingFile) -eq $false) {
            $f3 = New-TeamsFact -Name 'Calling File:' -Value $CallingFile
            $facts += $f3
        }
        
        if( $ErrorCode -ne 0){
            $f4 = New-TeamsFact -Name 'Error Code:' -Value $ErrorCode
            $facts += $f4
        }

        $s = New-TeamsSection `
            -ActivityDetails $facts `
            #-ActivityTitle $hash.Subtitle

        [RGBColors] $color = [RGBColors]::White

        switch($Level.ToLower()) 
        {
            emergency { $color= [RGBColors]::Tomato; break}
            alert {$color = [RGBColors]::DarkOrchid; Break }
            critical { $color = $color. [System.Console]::ForegroundColor = [ConsoleColor]::DarkMagenta ; Break}
            error { [System.Console]::ForegroundColor = [ConsoleColor]::Red; Break }
            warning { [System.Console]::ForegroundColor = [ConsoleColor]::Yellow; Break}
            notice { [System.Console]::ForegroundColor = [ConsoleColor]::Blue; Break}
            info { [System.Console]::ForegroundColor = [ConsoleColor]::Green; Break }
            debug { [System.Console]::ForegroundColor = [System.ConsoleColor]::Magenta; Break; }
            default { [System.Console]::ForegroundColor = [ConsoleColor]::White; Break }
        }

        Send-TeamsMessage `
            -URI $hash.URI `
            -MessageTitle $hash.MessageTitle `
            -Sections $s `
            -Color $color
    }

}