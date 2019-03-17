

function Invoke-ChainsawTeams {
    param (
        [string] $Level,
        [string] $Message,
        [int] $ErrorCode,
        [string] $CallingFile,
        [int] $LineNumber,
        [psobject] $Exception
    )
    
    Process{
        # Get the config for easy access
        $hash = Get-ChainsawConfig -Teams

        # If we have an Exception extract the message and replace our message
        if( $Exception -ne $null){
            $Message = $Exception.TargetObject
        }

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

        if( $LineNumber -ne 0){
            $f4 = New-TeamsFact -Name 'Line Number:' -Value $LineNumber
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
            critical { $color = [RGBColors]::DarkMagenta; Break}
            error { $color = [RGBColors]::Red; Break }
            warning { $color = [RGBColors]::Yellow; Break}
            notice { $color = [RGBColors]::Blue; Break}
            info { $color = [RGBColors]::Green; Break }
            debug { $color =[RGBColors]::Magenta; Break; }
            default { $color = [RGBColors]::White; Break }
        }

        Send-TeamsMessage `
            -URI $hash.URI `
            -MessageTitle $hash.MessageTitle `
            -Sections $s `
            -Color $color
    }

}