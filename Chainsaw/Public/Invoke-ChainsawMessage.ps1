
<#
.Synopsis
This will pass the message to all defined endpoints.

.Description
When you have a message from a process this will take care of all message routing for you.

.Parameter Emergency
[switch] This will define the messages level as Emergency.
Only define one of the switches.

.Parameter Alert
[switch] This will define the messages level as Alert.
Only define one of the switches.

.Parameter Critical
[switch] This will define the messages level as Critical.
Only define one of the switches.

.Parameter Error
[switch] This will define the messages level as Error.
Only define one of the switches.

.Parameter Warning
[switch] This will define the messages level as Warning.
Only define one of the switches.

.Parameter Notice
[switch] This will define the messages level as Notice.
Only define one of the switches.

.Parameter Info
[switch] This will define the messages level as Information.
Only define one of the switches.

.Parameter Debug
[switch] This will define the messages level as Debug.
Only define one of the switches.

.Parameter Message
[string] This will define the log message that you want to have recorded.

.Parameter ErrorCode
[int] This will let you define a custom error code if you wanted to.

.Parameter CallingFile
[string] This will let you define the filename that the message came from.
Use Get-CurrentFileName as a helper

.Parameter LineNumber
[int] This will let you define the line number that the message came from.
Use Get-CurrentLineNumber as a helper

#>
function Invoke-ChainsawMessage {
    #[cmdletbinding()]
    param (
        [switch] $Emergency,
        [switch] $Alert,
        [switch] $Critical,
        [switch] $Error,
        [switch] $Warning,
        [switch] $Notice,
        [switch] $Info,
        [switch] $Debug,

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
        
        [bool] $levelTest = Test-ChainsawMessageLevel -Console -Level $Level
        [bool] $endpointTest = Test-ChainsawEndpoint -Console

        if( $levelTest -eq $true -and $endpointTest -eq $true ){
            Invoke-ChainsawConsole -Level $Level `
                -Message $Message `
                -ErrorCode $ErrorCode `
                -CallingFile $CallingFile `
                -LineNumber $LineNumber
        }
        

        #CSV
        [bool] $levelTest = Test-ChainsawMessageLevel -CSV -Level $Level
        [bool] $endpointTest = Test-ChainsawEndpoint -CSV

        if( $levelTest -eq $true -and $endpointTest -eq $true ){
            Invoke-ChainsawCsv -Level $Level `
                -Message $Message `
                -ErrorCode $ErrorCode `
                -CallingFile $CallingFile `
                -LineNumber $LineNumber
        }
        

        #Teams
        [bool] $levelTest = Test-ChainsawMessageLevel -Teams -Level $Level
        [bool] $endpointTest = Test-ChainsawEndpoint -Teams

        if( $levelTest -eq $true -and $endpointTest -eq $true ){
            Invoke-ChainsawTeams -Level $Level `
                -Message $Message `
                -ErrorCode $ErrorCode `
                -CallingFile $CallingFile `
                -LineNumber $LineNumber
        }
    }
}