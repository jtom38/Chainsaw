
function Set-CsvConfig {
    param (
        [string] $Config,
        [string] $LogPath,
        [string] $Template
    )
    
    Process {
        if ( [System.String]::IsNullOrEmpty($Config) -eq $false ) {
            Import-PSLogCsvFromConfig -Config $Config
        }

        if( [System.String]::IsNullOrEmpty($LogPath) -eq $false ){
            $script:CsvLogPath = $LogPath
        }

        if( [System.String]::IsNullOrEmpty($Template) -eq $false ){
            $Script:CsvTemplate = $Template
        }
    }
}