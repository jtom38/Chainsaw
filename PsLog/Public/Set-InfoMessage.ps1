
function Set-PSLogInfo {
    param (
        [string] $Message, 
        [int] $ErrorCode, 
        [string] $CallingFile, 
        [int] $LineNumber
    )
    
    Process {

        if ( [System.String]::IsNullOrEmpty($Message) -eq $false -and
            [System.String]::IsNullOrEmpty($CallingFile) -eq $false){
                
            }


    }
}