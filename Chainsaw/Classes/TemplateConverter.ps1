
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
