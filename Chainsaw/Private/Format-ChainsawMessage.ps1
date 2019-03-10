

function Format-ChainsawMessage {
    [cmdletbinding()]
    param (
        [string] $Template,

        [string] $Message, 
        [string] $Level, 
        [string] $CallingFile, 
        [int] $LineNumber,

        [switch] $Header
    )
    
    Process{

        $s = $Template
        
        if($Header){
            if( $s.Contains("#Level#") -eq $true ){
                $s = $s.Replace("#Level#", 'Level')
            }
    
            if( $s.Contains("#DateTime#") -eq $true ){
                $s = $s.Replace("#DateTime#", 'DateTime')
            }
    
            if( $s.Contains("#Message#") -eq $true ){
                $s = $s.Replace("#Message#", 'Message')
            }
    
            if( $s.Contains("#LineNumber#") -eq $true){
                $s = $s.Replace("#LineNumber#", 'LineNumber')
            }
    
            if( $s.Contains("#CallingFile#") -eq $true){
                $s = $s.Replace("#CallingFile#", 'CallingFile')
            }
    
            return $s
        }
        else {
            if( $s.Contains("#Level#") -eq $true ){
                $s = $s.Replace("#Level#", $Level)
            }
    
            if( $s.Contains("#DateTime#") -eq $true ){
                $dt = [datetime]::Now
                $s = $s.Replace("#DateTime#", $dt)
            }
    
            if( $s.Contains("#Message#") -eq $true ){
                $s = $s.Replace("#Message#", $Message)
            }
    
            if( $s.Contains("#LineNumber#") -eq $true){
                $s = $s.Replace("#LineNumber#", $LineNumber)
            }
    
            if( $s.Contains("#File#") -eq $true){
                $s = $s.Replace("#File#", $File)
            }

            return $s
        }
    }
}