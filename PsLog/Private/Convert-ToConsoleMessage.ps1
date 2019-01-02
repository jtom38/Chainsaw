
function Convert-ToConsoleMessage {
    param (
        [Parameter(Mandatory=$true)][string] $Level,
        [Parameter(Mandatory=$true)][string] $Message
        #[Parameter(Mandatory=$true)][string] $LogFormat
    )
    
    Process {
        $s = "[#DateTime#] [#Level#] #Message#"
        
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
        return $s
    }
}