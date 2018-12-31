
class TemplateConverter {
    
    TemplateConverter(){

    }

    $TemErrorCode = -0
    

    [string] ConvertToMessageTemplate([string] $Level, [string] $Message, [int] $LineNumber, [string] $CallingFile){
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
            #$s = $s.Replace("#ErrorCode#", $ErrorCode)
        }
        return $s
    }

    [string] ConvertToMessageTemplate(  [string] $ErrorCode) {
        return $null
    }
}
