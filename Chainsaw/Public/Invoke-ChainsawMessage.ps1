
function Invoke-ChainsawMessage {
    [cmdletbinding()]
    param (
        [switch] $Emergency,
        [switch] $Alert,
        [switch] $Critical,
        [switch] $Error,
        [switch] $Warning,
        [switch] $Notice,
        [switch] $Info,
        #[switch] $Debug,

        [string] $Message,
        [int] $ErrorCode,
        [string] $CallingFile,
        [int] $LineNumber
    )
    
    Process{
        $Level = ""
        if($Emergency){$Level = 'Emergency'}
        elseif($Alert){$Level = 'Alert'}
        elseif($Critical){$Level = 'Critical'}
        elseif($Error){$Level = 'Error'}
        elseif($Warning){$Level = 'Warning'}
        elseif($Notice){$Level = 'Notice'}
        elseif($Info){$Level = 'Info'}
        elseif($Debug){$Level = 'Debug'}
        
        # Test all endpoints one by one to see who gets the message
        #Console
        <#
        $levelTest = Test-ChainsawMessageLevel -Console -Level $Level
        $endpointTest = Test-ChainsawEndpoint -Console -Level $msgLevel

        if( $levelTest -eq $true -and $endpointTest -eq $true ){
            Invoke-ChainsawConsole -Level $Level `
                -Message $Message `
                -ErrorCode $ErrorCode `
                -CallingFile $CallingFile `
                -LineNumber $LineNumber
        }
        #>

        #CSV
        $levelTest = Test-ChainsawMessageLevel -Console -Level $Level
        $endpointTest = Test-ChainsawEndpoint -Console

        if( $levelTest -eq $true -and $endpointTest -eq $true ){
            Invoke-ChainsawCsv -Level $Level `
                -Message $Message `
                -ErrorCode $ErrorCode `
                -CallingFile $CallingFile `
                -LineNumber $LineNumber
        }
    }
}