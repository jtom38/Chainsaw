
function Set-CsvConfig {
    param (
        [string] $Config,
        [string] $LogPath,
        [string] $Template,
        [string] $ReturnMessage
    )
    
    Process {
        if ( [System.String]::IsNullOrEmpty($Config) -eq $false ) {
            Import-PSLogCsvFromConfig -Config $Config
        }

        if( [System.String]::IsNullOrEmpty($LogPath) -eq $false ){
            $global:LogCsvLogPath = $LogPath
        }

        if( [System.String]::IsNullOrEmpty($Template) -eq $false ){
            $global:LogCsvTemplate = $Template
        }

        if( [System.String]::IsNullOrEmpty($ReturnMessage) -eq $false ) {
            $global:LogCsvReturnMessage = $ReturnMessage
        }
    }
}