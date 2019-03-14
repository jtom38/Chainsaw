

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

        [string] $MessageSummary = Format-ChainsawMessage `
            -Template $hash.MessageTemplate `
            -Message $Message `
            -Level $Level `
            -ErrorCode $ErrorCode `
            -LineNumber $LineNumber

        [Object[]] $facts = @()

        $f1 = New-TeamsFact -Name 'Message Level:' -Value $Level
        $facts += $f1

        if($Message -ne $null ) {
            $f2= New-TeamsFact -Name 'Message' -Value $Message
            $facts += $f2
        }

        if( [string]::IsNullOrEmpty($CallingFile) -eq $false) {
            $f3 = New-TeamsFact -Name 'Calling File:' -Value $CallingFile
            $facts += $f3
        }
        
        if( $ErrorCode -ne 0){
            $f4 = New-TeamsFact -Name 'Error Code:' -Value $ErrorCode
            $facts += $f4
        }

        $s = New-TeamsSection `
            -ActivityTitle 'Chainsaw' `
            -ActivityDetails $facts

        Send-TeamsMessage `
            -URI $hash.URI `
            -MessageTitle $hash.MessageTitle `
            -Sections $s `
    }

}