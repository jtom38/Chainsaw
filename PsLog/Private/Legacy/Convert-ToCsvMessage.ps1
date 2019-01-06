function Convert-ToCsvMessage {
    param (
        [Parameter(Mandatory=$true)][string] $Level,
        [Parameter(Mandatory=$true)][string] $Message,
        [Parameter(Mandatory=$true)][string] $LogFormat,
        [Parameter(Mandatory=$false)][string] $LineNumber,
        [Parameter(Mandatory=$false)][string] $CallingFile
    )

    Process{
        $s = $LogFormat

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

        return $s
    }
}